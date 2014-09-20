class Admin::VetContactsController < Admin::CrudController
  load_and_authorize_resource
  include PublicActivity::StoreController
  
  respond_to :html, :json, :csv

  # Allowed params for create and update
  self.permitted_attrs = [:clinic_name, :address, :phone, :email, :website, :hours, :emergency]
  # scope create to current_user.organization
  self.save_as_organization = true
  
  # GET /vet_contacts
  # GET /vet_contacts.xml
  def index
    @search = VetContact.organization(current_user).search(params[:q])
    @vet_contacts = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")

    respond_with(@vet_contacts) do |format|
      format.html # index.html.erb
      format.csv { render :csv => VetContact.organization(current_user),
                          :filename => 'vet_contacts' }
    end
  end
end
