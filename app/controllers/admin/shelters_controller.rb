class Admin::SheltersController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /shelters
  # GET /shelters.xml
  def index
    @search = Shelter.search(params[:search])
    @shelters = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shelters }
      format.xls { send_data Shelter.find(:all, :conditions => {:organization_id => current_user.organization_id}).to_xls, content_type: 'application/vnd.ms-excel', filename: 'shelters.xls' }
    end
  end

  # GET /shelters/1
  # GET /shelters/1.xml
  def show
    @shelter = Shelter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shelter }
    end
  end

  # GET /shelters/new
  # GET /shelters/new.xml
  def new
    @shelter = Shelter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shelter }
    end
  end

  # GET /shelters/1/edit
  def edit
    @shelter = Shelter.find(params[:id])
  end

  # POST /shelters
  # POST /shelters.xml
  def create
    @shelter = Shelter.new(params[:shelter])
    @shelter.organization_id = current_user.organization_id
    respond_to do |format|
      if @shelter.save
        format.html { 
          redirect_to(:back, :notice => 'Shelter was successfully created.')
          #redirect_to(@shelter, :notice => 'Shelter was successfully created.') 
          }
        format.xml  { render :xml => @shelter, :status => :created, :location => @shelter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shelter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shelters/1
  # PUT /shelters/1.xml
  def update
    @shelter = Shelter.find(params[:id])

    respond_to do |format|
      if @shelter.update_attributes(params[:shelter])
        format.html { redirect_to(@shelter, :notice => 'Shelter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shelter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shelters/1
  # DELETE /shelters/1.xml
  def destroy
    @shelter = Shelter.find(params[:id])
    @shelter.destroy

    respond_to do |format|
      format.html { redirect_to(shelters_url) }
      format.xml  { head :ok }
    end
  end
end
