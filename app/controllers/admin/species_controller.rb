class Admin::SpeciesController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /species
  # GET /species.xml
  def index
    @search = Species.includes(:animals).organization(current_user).search(params[:q])
    @species = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
    respond_with(@species)
  end

  # GET /species/1
  # GET /species/1.xml
  def show
    @species = Species.find(params[:id])
    @animals = Animal.where(:species_id => @species.id).order("name ASC")
    
    respond_with(@species)
  end

  # POST /species
  # POST /species.xml
  def create
    @species = current_user.organization.species.new(params[:species])
    if @species.save
      flash[:notice] = 'Species was successfully created.'
    else
      flash[:error] = 'Species was not successfully created.'
    end
    
    redirect_to :back
  end

  # DELETE /species/1
  # DELETE /species/1.xml
  def destroy
    @species = Species.find(params[:id])
    @species.destroy
    flash[:notice] = 'Successfully destroyed species.'
    
    redirect_to :back
  end
end
