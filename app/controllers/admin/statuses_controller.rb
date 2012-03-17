class Admin::StatusesController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /statuses
  # GET /statuses.xml
  def index
    @search = Status.search(params[:search])
    @statuses = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])
    @animals = Animal.find(:all, :conditions => {:status_id => @status.id})
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])
    @status.organization_id = current_user.organization_id
    respond_to do |format|
      if @status.save
        format.html { 
          redirect_to(:back, :notice => 'Status was successfully created.')
          }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to(@status, :notice => 'Status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
    end
  end
end