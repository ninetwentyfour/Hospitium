class Admin::AnimalWeightsController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
  # GET /animal_weights
  # GET /animal_weights.xml
  def index
    @search = AnimalWeight.includes(:animal).organization(current_user).search(params[:q])
    @animal_weights = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    @animals = Animal.organization(current_user).order("name")
    respond_with(@animal_weights) do |format|
      format.html
      format.csv { render :csv => AnimalWeight.includes(:animal).organization(current_user),
                          :filename => 'animal_weights' }
    end
  end

  # GET /animal_weights/1
  # GET /animal_weights/1.xml
  def show
    @animal_weight = AnimalWeight.find(params[:id])
    @animals = Animal.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.name.to_s]}
    
    respond_with(@animal_weight)
  end

  # POST /animal_weights
  # POST /animal_weights.xml
  def create
    @animal_weight = current_user.organization.animal_weights.new(params[:animal_weight])
    if @animal_weight.save
      flash[:notice] = 'Animal Weight was successfully created.'
    else
      flash[:error] = 'Animal Weight was not successfully created.'
    end
    
    redirect_to :back
  end
end
