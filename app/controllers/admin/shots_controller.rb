class Admin::ShotsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :xls
  
  # GET /shots
  # GET /shots.xml
  def index
    @search = Shot.organization(current_user).search(params[:q])
    @shots = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    # @presenter = Admin::Shots::IndexPresenter.new(current_user)
    respond_with(@shots) do |format|
      format.html
      # format.xls { send_data Shot.organization(current_user).to_xls,  content_type: 'application/vnd.ms-excel', filename: 'shots.xls' }
    end
  end

  # GET /shots/1
  # GET /shots/1.xml
  def show
    @shot = Shot.find(params[:id])
    
    respond_with(@shot)
  end

  # GET /shots/new
  # GET /shots/new.xml
  def new
    @shot = Shot.new
    
    respond_with(@shot)
  end

  # GET /shots/1/edit
  def edit
    @shot = Shot.find(params[:id])
  end

  # POST /shots
  # POST /shots.xml
  def create
    @shot = current_user.organization.shots.new(params[:shot])
    if @shot.save
      flash[:notice] = 'Shot was successfully created.'
    else
      flash[:error] = 'Shot was not successfully created.'
    end

    respond_with(@shot, :location => admin_shot_path(@shot))
  end

  # PUT /shots/1
  # PUT /shots/1.xml
  def update
    @shot = Shot.find(params[:id])
    @shot.update_attributes(params[:shot])
    
    respond_with(@shot, :location => admin_shot_path(@shot)) 
  end

  # DELETE /shots/1
  # DELETE /shots/1.xml
  def destroy
    @shot = Shot.find(params[:id])
    @shot.destroy
    flash[:notice] = 'Successfully destroyed shot.'
    
    respond_with(@shot, :location => admin_shots_path)
  end
end