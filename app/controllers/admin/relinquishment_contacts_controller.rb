class Admin::RelinquishmentContactsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv
  
  # GET /relinquishment_contacts
  # GET /relinquishment_contacts.xml
  def index
    @search = RelinquishmentContact.organization(current_user).search(params[:q])
    @relinquishment_contacts = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    @presenter = Admin::RelinquishmentContacts::IndexPresenter.new(current_user)
    respond_with(@relinquishment_contacts) do |format|
      format.html # index.html.erb
      format.csv { render :csv => RelinquishmentContact.organization(current_user),
                          :filename => 'relinquishment_contacts' }
    end
  end

  # GET /relinquishment_contacts/1
  # GET /relinquishment_contacts/1.xml
  def show
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
    @animals = RelinquishmentContact.find(params[:id]).animals
    @relatable_animals = Animal.organization(current_user)
    
    respond_with(@relinquishment_contact)
  end

  # GET /relinquishment_contacts/new
  # GET /relinquishment_contacts/new.xml
  def new
    @relinquishment_contact = RelinquishmentContact.new

    respond_with(@relinquishment_contact)
  end

  # GET /relinquishment_contacts/1/edit
  def edit
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
  end

  # POST /relinquishment_contacts
  # POST /relinquishment_contacts.xml
  def create
    @relinquishment_contact = current_user.organization.relinquishment_contacts.new(params[:relinquishment_contact])
    if @relinquishment_contact.save
      flash[:notice] = 'Relinquishment contact was successfully created.'
    else
      flash[:error] = 'Relinquishment contact was not successfully created.'
    end
    
    respond_with(@relinquishment_contact, :location => admin_relinquishment_contact_path(@relinquishment_contact))
  end

  # PUT /relinquishment_contacts/1
  # PUT /relinquishment_contacts/1.xml
  def update
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
    @relinquishment_contact.update_attributes(params[:relinquishment_contact])
    
    respond_with(@relinquishment_contact, :location => admin_relinquishment_contact_path(@relinquishment_contact))
  end

  # DELETE /relinquishment_contacts/1
  # DELETE /relinquishment_contacts/1.xml
  def destroy
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
    @relinquishment_contact.destroy
    flash[:notice] = 'Successfully destroyed relinquishment contact.'
    
    respond_with(@relinquishment_contact, :location => admin_relinquishment_contacts_path)
  end
end
