class Admin::UsersController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /users
  # GET /users.xml
  def index
    @search = User.search(params[:search])
    @users = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.organization_id = current_user.organization_id
    respond_to do |format|
      if @user.save
        #redirect_to(:back)
        format.html { 
          redirect_to(:back, :notice => 'User was successfully created.')
          #redirect_to(@user, :notice => 'User was successfully created.') 
          }
        format.xml  { render :xml => @user, :user => :created, :location => @user }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :user => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        #format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.html { 
          redirect_to(:back, :notice => 'User was successfully created.')
          #redirect_to(@animal_color, :notice => 'Animal color was successfully created.') 
          }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :user => :unprocessable_entity }
      end
    end
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
