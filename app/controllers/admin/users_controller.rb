class Admin::UsersController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /users
  # GET /users.xml
  def index
    @search = User.organization(current_user).search(params[:search])
    @users = @search.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
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

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_with(@user)
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
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

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    $statsd.increment 'user.updated'
    respond_with(@user, :location => admin_user_path(@user))
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
