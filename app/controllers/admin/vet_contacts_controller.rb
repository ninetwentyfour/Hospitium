class Admin::VetContactsController < Admin::ApplicationController
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

  # GET /vet_contacts/1
  # GET /vet_contacts/1.xml
  def show
    @vet_contact = VetContact.find(params[:id])

    respond_with(@vet_contact)
  end

  # GET /vet_contacts/new
  # GET /vet_contacts/new.xml
  def new
    @vet_contact = VetContact.new

    respond_with(@vet_contact)
  end

  # GET /vet_contacts/1/edit
  def edit
    @vet_contact = VetContact.find(params[:id])
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

  # PUT /vet_contacts/1
  # PUT /vet_contacts/1.xml
  def update
    @vet_contact = VetContact.find(params[:id])
    @vet_contact.update_attributes(params[:vet_contact])
    
    respond_with(@vet_contact, :location => admin_vet_contact_path(@vet_contact))
  end

  # DELETE /vet_contacts/1
  # DELETE /vet_contacts/1.xml
  def destroy
    @vet_contact = VetContact.find(params[:id])
    @vet_contact.destroy
    flash[:notice] = 'Successfully destroyed vet contact.'
    
    respond_with(@vet_contact, :location => admin_vet_contacts_path)
  end
end
