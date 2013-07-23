class Admin::AdoptAPetAccountsController < Admin::ApplicationController
  
  respond_to :html, :json

  def create
    @adopt_a_pet_account = AdoptAPetAccount.new_by_user(adopt_a_pet_account_params, current_user)
    if @adopt_a_pet_account.save
      flash[:notice] = 'Adopt A Pet Account Connected!'
    else
      flash[:error] = 'Adopt A Pet Account Was Not Connected!'
    end
    
    redirect_to "#{root_url}admin/users/#{current_user.id}"
  end
  
  def update
    @adopt_a_pet = AdoptAPetAccount.find(params[:id])
    params[:adopt_a_pet_account]["password"] = SecPass::encrypt(params[:adopt_a_pet_account]["password"])
    respond_to do |format|
      if  @adopt_a_pet.update_attributes(adopt_a_pet_account_params)
        format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Adopt A Pet Account updated!')}
      else
        format.html { render "new" }
      end
    end
  end
  
  
  def send_animal
    @account = AdoptAPetAccount.find_by_user_id(current_user.id)
    if @account.blank?
      redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Please Add Adopt A Pet Credentials!')
    else
      if @account.send_csv(current_user)
        redirect_to("#{root_url}admin/animals", :notice => 'Animals Sent To Adopt A Pet!')
      else
        redirect_to("#{root_url}admin/animals", :alert => 'Problem Sending Animals To Adopt A Pet!')
      end
    end
  end
  
  def destroy
    @account = AdoptAPetAccount.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html {redirect_to("#{root_url}admin/users/#{current_user.id}", :notice => 'Adopt A Pet Account Deleted!')}
      format.xml  { head :ok }
    end
  end

  private
    def adopt_a_pet_account_params
      params.require(:adopt_a_pet_account).permit(:user_name, :password)
    end
end

