class SpayNeutersController < ApplicationController
  # GET /spay_neuters
  # GET /spay_neuters.xml
  def index
    @spay_neuters = SpayNeuter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spay_neuters }
    end
  end

  # GET /spay_neuters/1
  # GET /spay_neuters/1.xml
  def show
    @spay_neuter = SpayNeuter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spay_neuter }
    end
  end

  # GET /spay_neuters/new
  # GET /spay_neuters/new.xml
  def new
    @spay_neuter = SpayNeuter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spay_neuter }
    end
  end

  # GET /spay_neuters/1/edit
  def edit
    @spay_neuter = SpayNeuter.find(params[:id])
  end

  # POST /spay_neuters
  # POST /spay_neuters.xml
  def create
    @spay_neuter = SpayNeuter.new(params[:spay_neuter])

    respond_to do |format|
      if @spay_neuter.save
        format.html { redirect_to(@spay_neuter, :notice => 'Spay neuter was successfully created.') }
        format.xml  { render :xml => @spay_neuter, :status => :created, :location => @spay_neuter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spay_neuter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /spay_neuters/1
  # PUT /spay_neuters/1.xml
  def update
    @spay_neuter = SpayNeuter.find(params[:id])

    respond_to do |format|
      if @spay_neuter.update_attributes(params[:spay_neuter])
        format.html { redirect_to(@spay_neuter, :notice => 'Spay neuter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spay_neuter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /spay_neuters/1
  # DELETE /spay_neuters/1.xml
  def destroy
    @spay_neuter = SpayNeuter.find(params[:id])
    @spay_neuter.destroy

    respond_to do |format|
      format.html { redirect_to(spay_neuters_url) }
      format.xml  { head :ok }
    end
  end
end
