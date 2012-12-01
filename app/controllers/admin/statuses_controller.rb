class Admin::StatusesController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /statuses
  # GET /statuses.xml
  def index
    @search = Status.includes(:animals).organization(current_user).search(params[:search])
    @statuses = @search.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
    respond_with(@statuses)
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])
    @animals = Animal.where(:status_id => @status.id).order("name ASC")
    
    respond_with(@status)
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_with(@status)
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = current_user.organization.statuses.new(params[:status])
    if @status.save
      flash[:notice] = 'Status was successfully created.'
    else
      flash[:error] = 'Status was not successfully created.'
    end
    
    redirect_to :back
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])
    @status.update_attributes(params[:status])
    
    respond_with(@status, :location => admin_status_path(@status))
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    flash[:notice] = 'Successfully destroyed status.'
    
    respond_with(@status, :location => admin_statuses_path)
  end
end
