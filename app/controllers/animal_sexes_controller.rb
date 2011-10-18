class AnimalSexesController < ApplicationController
  # GET /animal_sexes
  # GET /animal_sexes.xml
  def index
    @animal_sexes = AnimalSex.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animal_sexes }
    end
  end

  # GET /animal_sexes/1
  # GET /animal_sexes/1.xml
  def show
    @animal_sex = AnimalSex.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @animal_sex }
    end
  end

  # GET /animal_sexes/new
  # GET /animal_sexes/new.xml
  def new
    @animal_sex = AnimalSex.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @animal_sex }
    end
  end

  # GET /animal_sexes/1/edit
  def edit
    @animal_sex = AnimalSex.find(params[:id])
  end

  # POST /animal_sexes
  # POST /animal_sexes.xml
  def create
    @animal_sex = AnimalSex.new(params[:animal_sex])

    respond_to do |format|
      if @animal_sex.save
        format.html { redirect_to(@animal_sex, :notice => 'Animal sex was successfully created.') }
        format.xml  { render :xml => @animal_sex, :status => :created, :location => @animal_sex }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal_sex.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animal_sexes/1
  # PUT /animal_sexes/1.xml
  def update
    @animal_sex = AnimalSex.find(params[:id])

    respond_to do |format|
      if @animal_sex.update_attributes(params[:animal_sex])
        format.html { redirect_to(@animal_sex, :notice => 'Animal sex was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @animal_sex.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_sexes/1
  # DELETE /animal_sexes/1.xml
  def destroy
    @animal_sex = AnimalSex.find(params[:id])
    @animal_sex.destroy

    respond_to do |format|
      format.html { redirect_to(animal_sexes_url) }
      format.xml  { head :ok }
    end
  end
end
