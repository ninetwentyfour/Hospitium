class Admin::VolunteerContactsController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
  # GET /volunteer_contacts
  # GET /volunteer_contacts.xml
  def index
    @search = VolunteerContact.organization(current_user).search(params[:q])
    @volunteer_contacts = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")

    respond_with(@volunteer_contacts) do |format|
      format.html # index.html.erb
      format.csv { render :csv => VolunteerContact.organization(current_user),
                          :filename => 'volunteer_contacts' }
    end
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
end
