class Admin::UsersController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /users
  # GET /users.xml
  def index
    @search = User.organization(current_user).search(params[:q])
    @users = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
    respond_with(@users)
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.select("users.adopt_a_pets.name, users.username").
                  includes(:wordpress_accounts, :facebook_accounts, :twitter_accounts, :roles, :adopt_a_pet_accounts).
                  where(:id => params[:id]).
                  first()
    
    respond_with(@user)
  end

  # POST /users
  # POST /users.xml
  def create
    @user = current_user.organization.users.new(params[:user])
    if @user.save
      $statsd.increment 'user.created'
      flash[:notice] = 'User was successfully created.'
    else
      flash[:error] = 'User was not successfully created.'
    end
    
    redirect_to :back
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'User was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
