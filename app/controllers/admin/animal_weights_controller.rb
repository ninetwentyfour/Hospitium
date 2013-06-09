class Admin::AnimalWeightsController < Admin::ApplicationController
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

  # GET /animal_weights/new
  # GET /animal_weights/new.xml
  def new
    @animal_weight = AnimalWeight.new

    respond_with(@animal_weight)
  end

  # GET /animal_weights/1/edit
  def edit
    @animal_weight = AnimalWeight.find(params[:id])
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

  # PUT /animal_weights/1
  # PUT /animal_weights/1.xml
  def update
    @animal_weight = AnimalWeight.find(params[:id])
    @animal_weight.update_attributes(params[:animal_weight])
    
    respond_with(@animal_weight, :location => admin_animal_weight_path(@animal_weight)) 
  end

  # DELETE /animal_weights/1
  # DELETE /animal_weights/1.xml
  def destroy
    @animal_weight = AnimalWeight.find(params[:id])
    @animal_weight.destroy
    flash[:notice] = 'Successfully destroyed animal weight.'
    
    respond_with(@animal_weight, :location => admin_animal_weights_path)
  end
end
