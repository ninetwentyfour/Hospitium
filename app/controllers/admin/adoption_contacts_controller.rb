class Admin::AdoptionContactsController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
  # GET /adoption_contacts
  # GET /adoption_contacts.xml
  def index
    @presenter = Admin::AdoptionContacts::IndexPresenter.new(current_user, params[:page], params[:q])
    respond_with(@adoption_contacts) do |format|
      format.html
      format.csv { render :csv => AdoptionContact.organization(current_user),
                          :filename => 'adoption_contacts' }
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
end
