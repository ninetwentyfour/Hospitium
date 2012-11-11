class RelinquishAnimalsController < ApplicationController
  # GET /biters
  # GET /biters.xml
  def index
    @relinquish_animals = RelinquishAnimal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relinquish_animal }
    end
  end

  # GET /biters/1
  # GET /biters/1.xml
  def show
    @relinquish_animal = RelinquishAnimal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relinquish_animal }
    end
  end

  # GET /biters/new
  # GET /biters/new.xml
  def new
    @relinquish_animal = RelinquishAnimal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relinquish_animal }
    end
  end

  # GET /biters/1/edit
  def edit
    @relinquish_animal = RelinquishAnimal.find(params[:id])
  end

  # POST /biters
  # POST /biters.xml
  def create
    @relinquish_animal = RelinquishAnimal.new(params[:relinquish_animal])

    respond_to do |format|
      if @relinquish_animal.save
        format.html { 
          redirect_to(:back, :notice => 'Animal successfully added.')
          }
        format.xml  { render :xml => @relinquish_animal, :status => :created, :location => @relinquish_animal }
      else
        format.html { render "new" }
        format.xml  { render :xml => @relinquish_animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /biters/1
  # PUT /biters/1.xml
  def update
    @relinquish_animal = RelinquishAnimal.find(params[:id])

    respond_to do |format|
      if @relinquish_animal.update_attributes(params[:relinquish_animal])
        format.html { redirect_to(@relinquish_animal, :notice => 'RelinquishAnimal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render "edit" }
        format.xml  { render :xml => @relinquish_animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @relinquish_animal = RelinquishAnimal.find_by_animal_id_and_relinquishment_contact_id(params[:id], params[:relinquish])
    @relinquish_animal.destroy

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Animal successfully removed.') }
      format.xml  { head :ok }
    end
  end
end
