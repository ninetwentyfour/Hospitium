class Admin::UsersController < Admin::CrudController
  load_and_authorize_resource
  
  # Allowed params for create and update
  self.permitted_attrs = [:email, :password, :password_confirmation, :remember_me, :username, :login, :organization_name, :owner,
                          :no_send_email, :skip_default_role]
  # scope create to current_user.organization
  self.save_as_organization = true
  # redirect somewhere other than the object on create/delete
  self.redirect_on_create = :back
  self.redirect_on_delete = :back
  
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
                  references(:adopt_a_pets).
                  includes(:wordpress_accounts, :facebook_accounts, :twitter_accounts, :roles, :adopt_a_pet_accounts).
                  where(:id => params[:id]).
                  first()
    
    respond_with(@user)
  end
end
