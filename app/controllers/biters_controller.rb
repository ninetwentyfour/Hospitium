class BitersController < ApplicationController
  # GET /biters
  # GET /biters.xml
  def index
    @biters = Biter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @biters }
    end
  end

  # GET /biters/1
  # GET /biters/1.xml
  def show
    @biter = Biter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @biter }
    end
  end

  # GET /biters/new
  # GET /biters/new.xml
  def new
    @biter = Biter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @biter }
    end
  end

  # GET /biters/1/edit
  def edit
    @biter = Biter.find(params[:id])
  end

  # POST /biters
  # POST /biters.xml
  def create
    @biter = Biter.new(params[:biter])

    respond_to do |format|
      if @biter.save
        format.html { redirect_to(@biter, :notice => 'Biter was successfully created.') }
        format.xml  { render :xml => @biter, :status => :created, :location => @biter }
      else
        format.html { render "new" }
        format.xml  { render :xml => @biter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /biters/1
  # PUT /biters/1.xml
  def update
    @biter = Biter.find(params[:id])

    respond_to do |format|
      if @biter.update_attributes(params[:biter])
        format.html { redirect_to(@biter, :notice => 'Biter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render "edit" }
        format.xml  { render :xml => @biter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @biter = Biter.find(params[:id])
    @biter.destroy

    respond_to do |format|
      format.html { redirect_to(biters_url) }
      format.xml  { head :ok }
    end
  end
end
