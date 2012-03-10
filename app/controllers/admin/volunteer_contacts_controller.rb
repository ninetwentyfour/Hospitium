class Admin::VolunteerContactsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /volunteer_contacts
  # GET /volunteer_contacts.xml
  def index
    #@volunteer_contacts = VolunteerContact.all
    @search = VolunteerContact.search(params[:search])
    @volunteer_contacts = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteer_contacts }
    end
  end

  # GET /volunteer_contacts/1
  # GET /volunteer_contacts/1.xml
  def show
    @volunteer_contact = VolunteerContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @volunteer_contact }
    end
  end

  # GET /volunteer_contacts/new
  # GET /volunteer_contacts/new.xml
  def new
    @volunteer_contact = VolunteerContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @volunteer_contact }
    end
  end

  # GET /volunteer_contacts/1/edit
  def edit
    @volunteer_contact = VolunteerContact.find(params[:id])
  end

  # POST /volunteer_contacts
  # POST /volunteer_contacts.xml
  def create
    @volunteer_contact = VolunteerContact.new(params[:volunteer_contact])
    @volunteer_contact.organization_id = current_user.organization_id
    respond_to do |format|
      if @volunteer_contact.save
        format.html { redirect_to(@volunteer_contact, :notice => 'Volunteer contact was successfully created.') }
        format.xml  { render :xml => @volunteer_contact, :status => :created, :location => @volunteer_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @volunteer_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /volunteer_contacts/1
  # PUT /volunteer_contacts/1.xml
  def update
    @volunteer_contact = VolunteerContact.find(params[:id])

    respond_to do |format|
      if @volunteer_contact.update_attributes(params[:volunteer_contact])
        format.html { redirect_to(@volunteer_contact, :notice => 'Volunteer contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @volunteer_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteer_contacts/1
  # DELETE /volunteer_contacts/1.xml
  def destroy
    @volunteer_contact = VolunteerContact.find(params[:id])
    @volunteer_contact.destroy

    respond_to do |format|
      format.html { redirect_to(volunteer_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
