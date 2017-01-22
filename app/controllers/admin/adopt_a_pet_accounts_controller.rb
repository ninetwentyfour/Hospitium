class Admin::AdoptAPetAccountsController < Admin::ApplicationController
  respond_to :html, :json

  def create
    @adopt_a_pet_account = AdoptAPetAccount.new_by_user(adopt_a_pet_account_params, current_user)
    if @adopt_a_pet_account.save
      flash[:notice] = 'Adopt A Pet Account Connected!'
    else
      flash[:danger] = 'Adopt A Pet Account Was Not Connected!'
    end

    redirect_to "#{root_url}admin/users/#{current_user.id}"
  end

  def update
    @adopt_a_pet = AdoptAPetAccount.find(params[:id])
    params[:adopt_a_pet_account]['password'] = SecPass.encrypt(params[:adopt_a_pet_account]['password'])
    respond_to do |format|
      if @adopt_a_pet.update_attributes(adopt_a_pet_account_params)
        format.html { redirect_to("#{root_url}admin/users/#{current_user.id}", notice: 'Adopt A Pet Account updated!') }
      else
        format.html { render 'new' }
      end
    end
  end

  def send_animal
    @account = AdoptAPetAccount.find_by(user_id: current_user.id)
    if @account.blank?
      flash[:info] = 'Please Add Adopt A Pet Credentials!'
      redirect_to("#{root_url}admin/users/#{current_user.id}")
    else
      begin
        if @account.send_csv(current_user)
          redirect_to("#{root_url}admin/animals", notice: 'Animals Sent To Adopt A Pet!')
        else
          flash[:danger] = 'Problem Sending Animals To Adopt A Pet!'
          redirect_to("#{root_url}admin/animals")
        end
      rescue Net::FTPPermError
        flash[:danger] = 'Problem Sending Animals To Adopt A Pet! Please make sure your credentials are correct.'
        redirect_to("#{root_url}admin/animals")
      rescue => e
        notify_airbrake(e)
        flash[:danger] = 'Problem Sending Animals To Adopt A Pet!'
        redirect_to("#{root_url}admin/animals")
      end
    end
  end

  def destroy
    @account = AdoptAPetAccount.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to("#{root_url}admin/users/#{current_user.id}", notice: 'Adopt A Pet Account Deleted!') }
      format.xml  { head :ok }
    end
  end

  private

  def adopt_a_pet_account_params
    params.require(:adopt_a_pet_account).permit(:user_name, :password)
  end
end
