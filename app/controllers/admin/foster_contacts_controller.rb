class Admin::FosterContactsController < Admin::CrudController
  load_and_authorize_resource
  include PublicActivity::StoreController
  
  respond_to :html, :json, :csv, :vcf

  # Allowed params for create and update
  self.permitted_attrs = [:first_name, :last_name, :phone, :email, :address]
  # scope create to current_user.organization
  self.save_as_organization = true
  
  # GET /foster_contacts
  # GET /foster_contacts.xml
  def index
    @presenter = Admin::FosterContacts::IndexPresenter.new(current_user, params[:page], params[:q])
    respond_with(@foster_contacts) do |format|
      format.html
      format.csv { render :csv => FosterContact.organization(current_user),
                          :filename => 'foster_contacts' }
    end
  end

  # GET /foster_contacts/1
  # GET /foster_contacts/1.xml
  def show
    @foster_contact = FosterContact.find(params[:id])
    @animals = FosterContact.find(params[:id]).animals
    @adoptable_animals = Animal.organization(current_user)
    
    respond_with(@foster_contact)
    # respond_with(@foster_contact) do |format|
    #   format.vcf do
    #     @content = Admin::Contacts::VcardPresenter.new(@foster_contact).get_vcard
    #     response.headers['Content-Disposition'] = 'attachment; filename="' + @foster_contact.first_name.parameterize + '.vcf"'
    #     render "show.vcf.erb"
    #   end
    # end
  end
end
