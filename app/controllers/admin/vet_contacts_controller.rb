class Admin::VetContactsController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
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

  # POST /vet_contacts
  # POST /vet_contacts.xml
  def create
    @vet_contact = current_user.organization.vet_contacts.new(params[:vet_contact])
    if @vet_contact.save
      flash[:notice] = 'Vet contact was successfully created.'
    else
      flash[:error] = 'Vet contact was not successfully created.'
    end
    
    respond_with(@vet_contact, :location => admin_vet_contact_path(@vet_contact))
  end
end
