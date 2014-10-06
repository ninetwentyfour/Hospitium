class Admin::AnimalColorsController < Admin::CrudController
  load_and_authorize_resource
  # include PublicActivity::StoreController
  
  respond_to :html, :json

  # Allowed params for create and update
  self.permitted_attrs = [:color]
  # scope create to current_user.organization
  self.save_as_organization = true
  self.redirect_on_create = :back
  
  # GET /animal_colors
  # GET /animal_colors.xml
  def index
    @search = AnimalColor.includes(:animals).organization(current_user).search(params[:q])
    @animal_colors = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
    respond_with(@animal_colors)
  end

  # GET /animal_colors/1
  # GET /animal_colors/1.xml
  def show
    @animal_color = AnimalColor.find(params[:id])
    @animals = Animal.where(:animal_color_id => @animal_color.id).order("name ASC")
    
    respond_with(@animal_color)
  end
end
