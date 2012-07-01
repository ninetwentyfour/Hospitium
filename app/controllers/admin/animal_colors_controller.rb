class Admin::AnimalColorsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json
  
  # GET /animal_colors
  # GET /animal_colors.xml
  def index
    @search = AnimalColor.organization(current_user).search(params[:search])
    @animal_colors = @search.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    
    respond_with(@animal_colors)
  end

  # GET /animal_colors/1
  # GET /animal_colors/1.xml
  def show
    @animal_color = AnimalColor.find(params[:id])
    @animals = Animal.where(:animal_color_id => @animal_color.id)
    
    respond_with(@animal_color, @animals)
  end

  # GET /animal_colors/new
  # GET /animal_colors/new.xml
  def new
    @animal_color = AnimalColor.new
    
    respond_with(@animal_color)
  end

  # GET /animal_colors/1/edit
  def edit
    @animal_color = AnimalColor.find(params[:id])
  end

  # POST /animal_colors
  # POST /animal_colors.xml
  def create
    @animal_color = current_user.organization.animal_colors.new(params[:animal_color])
    if @animal_color.save
      flash[:notice] = 'Animal Color was successfully created.'
    else
      flash[:error] = 'Animal Color was not successfully created.'
    end
    
    respond_with(@animal_color, :location => admin_animal_color_path(@animal_color))
  end

  # PUT /animal_colors/1
  # PUT /animal_colors/1.xml
  def update
    @animal_color = AnimalColor.find(params[:id])
    @animal_color.update_attributes(params[:animal_color])
    
    respond_with(@animal_color, :location => admin_animal_color_path(@animal_color))    
  end

  # DELETE /animal_colors/1
  # DELETE /animal_colors/1.xml
  def destroy
    @animal_color = AnimalColor.find(params[:id])
    @animal_color.destroy
    flash[:notice] = 'Successfully destroyed animal color.'
    
    respond_with(@animal_color, :location => admin_animal_colors_path)
  end
end
