class Admin::SpeciesController < Admin::CrudController
  load_and_authorize_resource
  
  # Allowed params for create and update
  self.permitted_attrs = [:name]
  # scope create to current_user.organization
  self.save_as_organization = true
  # redirect somewhere other than the object on create/delete
  self.redirect_on_create = :back
  self.redirect_on_delete = :back
  
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
end
