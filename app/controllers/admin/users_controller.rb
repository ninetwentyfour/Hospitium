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
    @user = User.where(:id => params[:id]).
                  first()
    
    respond_with(@user)
  end

  def edit
    redirect_to admin_users_path
  end

  def cancel
    user = User.where(id: params[:id]).first

    Thread.new do
      org = Organization.where(id: user.organization_id).first
      org.destroy
    end

    sign_out user

    flash[:notice] = 'Account successfully cancelled.'
    redirect_to root_path
  end
end
