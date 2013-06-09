class Admin::ShotsController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
  # GET /shots
  # GET /shots.csv
  def index
    @presenter = Admin::Shots::IndexPresenter.new(current_user, params[:page], params[:q])
    respond_with(@shots) do |format|
      format.html
      format.csv { render :csv => Shot.includes(:animal).organization(current_user),
                          :filename => 'shots' }
    end
  end

  # GET /shots/1
  # GET /shots/1.xml
  def show
    @presenter = Admin::Shots::ShowPresenter.new(params[:id], current_user)

    respond_with(@shot)
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
end