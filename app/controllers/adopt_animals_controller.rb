class AdoptAnimalsController < ApplicationController
  # GET /biters
  # GET /biters.xml
  def index
    @adopt_animals = AdoptAnimal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adopt_animals }
    end
  end

  # GET /biters/1
  # GET /biters/1.xml
  def show
    @adopt_animal = AdoptAnimal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adopt_animal }
    end
  end

  # GET /biters/new
  # GET /biters/new.xml
  def new
    @adopt_animal = AdoptAnimal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adopt_animal }
    end
  end

  # GET /biters/1/edit
  def edit
    @adopt_animal = AdoptAnimal.find(params[:id])
  end

  # POST /biters
  # POST /biters.xml
  def create
    @adopt_animal = AdoptAnimal.new(params[:adopt_animal])

    respond_to do |format|
      if @adopt_animal.save
        format.html { 
          redirect_to(:back, :notice => 'Animal successfully added.')
          #redirect_to(@species, :notice => 'Species was successfully created.') 
          }
        format.xml  { render :xml => @adopt_animal, :status => :created, :location => @adopt_animal }
      else
        format.html { render "new" }
        format.xml  { render :xml => @adopt_animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /biters/1
  # PUT /biters/1.xml
  def update
    @adopt_animal = AdoptAnimal.find(params[:id])

    respond_to do |format|
      if @adopt_animal.update_attributes(params[:adopt_animal])
        format.html { redirect_to(@adopt_animal, :notice => 'AdoptAnimal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render "edit" }
        format.xml  { render :xml => @adopt_animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @adopt_animal = AdoptAnimal.find_by_animal_id_and_adoption_contact_id(params[:id], params[:adopt])
    @adopt_animal.destroy

    respond_to do |format|
      format.html { 
        redirect_to(:back, :notice => 'Animal successfully removed.')
        #redirect_to(@species, :notice => 'Species was successfully created.') 
        }
      format.xml  { head :ok }
    end
  end
end
