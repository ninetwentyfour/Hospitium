class AnimalsController < ApplicationController
  #caches_action :index, :expires_in => 1.minute
  caches_action :show, :expires_in => 1.minute
  #cache_sweeper :animal_sweeper
  # GET /animals
  # GET /animals.xml
  def index
    #find animals that are public to show on animals for adoption page
    @animals = Animal.paginate(:page => params[:page], :per_page => 10, :conditions => {'public' => 1}, :order => "updated_at DESC", 
        :select => 'animals.uuid, animals.name, animals.special_needs, animals.animal_color_id, animals.animal_sex_id, animals.species_id, animals.status_id, animals.organization_id, animals.spay_neuter_id, animals.image, animals.image_file_name', 
        :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter])
    #Post.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animals }
      format.json  { render :json => @animals }
    end
  end

  # GET /animals/1
  # GET /animals/1.xml
  def show
    @animal = Animal.find_by_uuid(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @animal }
    end
  end

  # GET /animals/new
  # GET /animals/new.xml
  def new
    @animal = Animal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @animal }
    end
  end

  # GET /animals/1/edit
  def edit
    @animal = Animal.find(params[:id])
  end

  # POST /animals
  # POST /animals.xml
  def create
    @animal = Animal.new(params[:animal])

    respond_to do |format|
      if @animal.save
        format.html { redirect_to(@animal, :notice => 'Animal was successfully created.') }
        format.xml  { render :xml => @animal, :status => :created, :location => @animal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animals/1
  # PUT /animals/1.xml
  def update
    @animal = Animal.find(params[:id])

    respond_to do |format|
      if @animal.update_attributes(params[:animal])
        format.html { redirect_to(@animal, :notice => 'Animal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.xml
  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy

    respond_to do |format|
      format.html { redirect_to(animals_url) }
      format.xml  { head :ok }
    end
  end
end
