class Admin::StatusesController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /statuses
  # GET /statuses.xml
  def index
    @search = Status.includes(:animals).organization(current_user).search(params[:q])
    @statuses = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
    respond_with(@statuses)
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])
    @animals = Animal.where(:status_id => @status.id).order("name ASC")
    
    respond_with(@status)
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
end
