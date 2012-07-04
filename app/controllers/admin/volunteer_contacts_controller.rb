class Admin::VolunteerContactsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :xls
  
  # GET /volunteer_contacts
  # GET /volunteer_contacts.xml
  def index
    @search = VolunteerContact.organization(current_user).search(params[:search])
    @volunteer_contacts = @search.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")

    respond_with(@volunteer_contacts) do |format|
      format.html # index.html.erb
      format.xls { send_data VolunteerContact.organization(current_user).to_xls, content_type: 'application/vnd.ms-excel', filename: 'volunteer_contacts.xls' }
    end
  end

  # GET /volunteer_contacts/1
  # GET /volunteer_contacts/1.xml
  def show
    @volunteer_contact = VolunteerContact.find(params[:id])

    respond_with(@volunteer_contact)
  end

  # GET /volunteer_contacts/new
  # GET /volunteer_contacts/new.xml
  def new
    @volunteer_contact = VolunteerContact.new

    respond_with(@volunteer_contact)
  end

  # GET /volunteer_contacts/1/edit
  def edit
    @volunteer_contact = VolunteerContact.find(params[:id])
  end

  # POST /volunteer_contacts
  # POST /volunteer_contacts.xml
  def create
    @volunteer_contact = current_user.organization.volunteer_contacts.new(params[:volunteer_contact])
    if @volunteer_contact.save
      flash[:notice] = 'Volunteer contact was successfully created.'
    else
      flash[:error] = 'Volunteer contact was not successfully created.'
    end
    
    respond_with(@volunteer_contact, :location => admin_volunteer_contact_path(@volunteer_contact))
  end

  # PUT /volunteer_contacts/1
  # PUT /volunteer_contacts/1.xml
  def update
    @volunteer_contact = VolunteerContact.find(params[:id])
    @volunteer_contact.update_attributes(params[:volunteer_contact])
    
    respond_with(@volunteer_contact, :location => admin_volunteer_contact_path(@volunteer_contact))
  end

  # DELETE /volunteer_contacts/1
  # DELETE /volunteer_contacts/1.xml
  def destroy
    @volunteer_contact = VolunteerContact.find(params[:id])
    @volunteer_contact.destroy
    flash[:notice] = 'Successfully destroyed volunteer contact.'
    
    respond_with(@volunteer_contact, :location => admin_volunteer_contacts_path)
  end
end
