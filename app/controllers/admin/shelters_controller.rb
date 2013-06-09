class Admin::SheltersController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
  # GET /shelters
  # GET /shelters.xml
  def index
    @search = Shelter.includes(:animals).organization(current_user).search(params[:q])
    @shelters = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    respond_with(@shelters) do |format|
      format.html # index.html.erb
      format.csv { render :csv => Shelter.organization(current_user),
                          :filename => 'shelters' }
    end
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
end
