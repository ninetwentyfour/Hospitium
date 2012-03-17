class Admin::AnimalColorsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /animal_colors
  # GET /animal_colors.xml
  def index
    @search = AnimalColor.search(params[:search])
    @animal_colors = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animal_colors }
    end
  end

  # GET /animal_colors/1
  # GET /animal_colors/1.xml
  def show
    @animal_color = AnimalColor.find(params[:id])
    @animals = Animal.find(:all, :conditions => {:animal_color_id => @animal_color.id })

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @animal_color }
    end
  end

  # GET /animal_colors/new
  # GET /animal_colors/new.xml
  def new
    @animal_color = AnimalColor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @animal_color }
    end
  end

  # GET /animal_colors/1/edit
  def edit
    @animal_color = AnimalColor.find(params[:id])
  end

  # POST /animal_colors
  # POST /animal_colors.xml
  def create
    @animal_color = AnimalColor.new(params[:animal_color])
    @animal_color.organization_id = current_user.organization_id
    respond_to do |format|
      if @animal_color.save
        format.html { 
          redirect_to(:back, :notice => 'Animal Color was successfully created.')
          }
        format.xml  { render :xml => @animal_color, :status => :created, :location => @animal_color }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal_color.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /animal_colors/1
  # PUT /animal_colors/1.xml
  def update
    @animal_color = AnimalColor.find(params[:id])

    respond_to do |format|
      if @animal_color.update_attributes(params[:animal_color])
        format.html { redirect_to(@animal_color, :notice => 'Animal color was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @animal_color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_colors/1
  # DELETE /animal_colors/1.xml
  def destroy
    @animal_color = AnimalColor.find(params[:id])
    @animal_color.destroy

    respond_to do |format|
      format.html { redirect_to(animal_colors_url) }
      format.xml  { head :ok }
    end
  end
end