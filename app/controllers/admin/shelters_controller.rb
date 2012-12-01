class Admin::SheltersController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :xls
  
  # GET /shelters
  # GET /shelters.xml
  def index
    @search = Shelter.includes(:animals).organization(current_user).search(params[:search])
    @shelters = @search.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    respond_with(@shelters) do |format|
      format.html # index.html.erb
      format.xls { send_data Shelter.organization(current_user).to_xls, content_type: 'application/vnd.ms-excel', filename: 'shelters.xls' }
    end
  end

  # GET /shelters/1
  # GET /shelters/1.xml
  def show
    @shelter = Shelter.find(params[:id])

    respond_with(@shelter)
  end

  # GET /shelters/new
  # GET /shelters/new.xml
  def new
    @shelter = Shelter.new

    @shelter
  end

  # GET /shelters/1/edit
  def edit
    @shelter = Shelter.find(params[:id])
  end

  # POST /shelters
  # POST /shelters.xml
  def create
    @shelter = current_user.organization.shelters.new(params[:shelter])
    if @shelter.save
      flash[:notice] = 'Shelter was successfully created.'
    else
      flash[:error] = 'Shelter was not successfully created.'
    end
    
    redirect_to :back
  end

  # PUT /shelters/1
  # PUT /shelters/1.xml
  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update_attributes(params[:shelter])
    
    respond_with(@shelter, :location => admin_shelter_path(@shelter))
  end

  # DELETE /shelters/1
  # DELETE /shelters/1.xml
  def destroy
    @shelter = Shelter.find(params[:id])
    @shelter.destroy
    flash[:notice] = 'Successfully destroyed shelter.'
    
    respond_with(@shelter, :location => admin_shelters_path)
  end
end
