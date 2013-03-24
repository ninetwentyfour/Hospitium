class Admin::AdoptionContactsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :xls
  
  # GET /adoption_contacts
  # GET /adoption_contacts.xml
  def index
    @search = AdoptionContact.organization(current_user).search(params[:search])
    @adoption_contacts = @search.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    respond_with(@adoption_contacts) do |format|
      format.html
      format.xls { send_data AdoptionContact.organization(current_user).to_xls,  content_type: 'application/vnd.ms-excel', filename: 'adoption_contacts.xls' }
    end
  end

  # GET /adoption_contacts/1
  # GET /adoption_contacts/1.xml
  def show
    @adoption_contact = AdoptionContact.find(params[:id])
    @animals = AdoptionContact.find(params[:id]).animals
    @adoptable_animals = Animal.organization(current_user)
    
    respond_with(@adoption_contact)
  end

  # GET /adoption_contacts/new
  # GET /adoption_contacts/new.xml
  def new
    @adoption_contact = AdoptionContact.new
    
    respond_with(@adoption_contact)
  end

  # GET /adoption_contacts/1/edit
  def edit
    @adoption_contact = AdoptionContact.find(params[:id])
  end

  # POST /adoption_contacts
  # POST /adoption_contacts.xml
  def create
    @adoption_contact = current_user.organization.adoption_contacts.new(params[:adoption_contact])
    if @adoption_contact.save
      flash[:notice] = 'Adoption contact was successfully created.'
    else
      flash[:error] = 'Adoption contact was not successfully created.'
    end

    respond_with(@adoption_contact, :location => admin_adoption_contact_path(@adoption_contact))
  end

  # PUT /adoption_contacts/1
  # PUT /adoption_contacts/1.xml
  def update
    @adoption_contact = AdoptionContact.find(params[:id])
    @adoption_contact.update_attributes(params[:adoption_contact])
    
    respond_with(@adoption_contact, :location => admin_adoption_contact_path(@adoption_contact)) 
  end

  # DELETE /adoption_contacts/1
  # DELETE /adoption_contacts/1.xml
  def destroy
    @adoption_contact = AdoptionContact.find(params[:id])
    @adoption_contact.destroy
    flash[:notice] = 'Successfully destroyed adoption contact.'
    
    respond_with(@adoption_contact, :location => admin_adoption_contacts_path)
  end
end
