class Admin::SpeciesController < Admin::ApplicationController
  load_and_authorize_resource
  
  # GET /species
  # GET /species.xml
  def index
    @search = Species.search(params[:search])
    @species = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @species }
    end
  end

  # GET /species/1
  # GET /species/1.xml
  def show
    @species = Species.find(params[:id])
    @animals = Animal.where(:species_id => @species.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @species }
    end
  end

  # GET /species/new
  # GET /species/new.xml
  def new
    @species = Species.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @species }
    end
  end

  # GET /species/1/edit
  def edit
    @species = Species.find(params[:id])
  end

  # POST /species
  # POST /species.xml
  def create
    @species = Species.new(params[:species])
    @species.organization_id = current_user.organization_id
    respond_to do |format|
      if @species.save
        format.html { 
          redirect_to(:back, :notice => 'Species was successfully created.')
          }
        format.xml  { render :xml => @species, :status => :created, :location => @species }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @species.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /species/1
  # PUT /species/1.xml
  def update
    @species = Species.find(params[:id])

    respond_to do |format|
      if @species.update_attributes(params[:species])
        format.html { redirect_to(@species, :notice => 'Species was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @species.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /species/1
  # DELETE /species/1.xml
  def destroy
    @species = Species.find(params[:id])
    @species.destroy

    respond_to do |format|
      format.html { redirect_to(species_index_url) }
      format.xml  { head :ok }
    end
  end
end
