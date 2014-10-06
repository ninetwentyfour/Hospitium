class Admin::AdoptionContactsController < Admin::CrudController
  load_and_authorize_resource
  include PublicActivity::StoreController
  
  respond_to :html, :json, :csv

  # Allowed params for create and update
  self.permitted_attrs = [:first_name, :last_name, :phone, :email, :adopted_date, :address]
  # scope create to current_user.organization
  self.save_as_organization = true
  
  # GET /adoption_contacts
  # GET /adoption_contacts.xml
  def index
    @presenter = Admin::AdoptionContacts::IndexPresenter.new(current_user, params[:page], params[:q], params[:animal_id])
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
end
