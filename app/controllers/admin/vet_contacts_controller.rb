class Admin::VetContactsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /vet_contacts
  # GET /vet_contacts.xml
  def index
    #@vet_contacts = VetContact.all
    @search = VetContact.search(params[:search])
    @vet_contacts = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vet_contacts }
    end
  end

  # GET /vet_contacts/1
  # GET /vet_contacts/1.xml
  def show
    @vet_contact = VetContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vet_contact }
    end
  end

  # GET /vet_contacts/new
  # GET /vet_contacts/new.xml
  def new
    @vet_contact = VetContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vet_contact }
    end
  end

  # GET /vet_contacts/1/edit
  def edit
    @vet_contact = VetContact.find(params[:id])
  end

  # POST /vet_contacts
  # POST /vet_contacts.xml
  def create
    @vet_contact = VetContact.new(params[:vet_contact])
    @vet_contact.organization_id = current_user.organization_id
    respond_to do |format|
      if @vet_contact.save
        format.html { redirect_to(@vet_contact, :notice => 'Vet contact was successfully created.') }
        format.xml  { render :xml => @vet_contact, :status => :created, :location => @vet_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vet_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vet_contacts/1
  # PUT /vet_contacts/1.xml
  def update
    @vet_contact = VetContact.find(params[:id])

    respond_to do |format|
      if @vet_contact.update_attributes(params[:vet_contact])
        format.html { redirect_to(@vet_contact, :notice => 'Vet contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vet_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vet_contacts/1
  # DELETE /vet_contacts/1.xml
  def destroy
    @vet_contact = VetContact.find(params[:id])
    @vet_contact.destroy

    respond_to do |format|
      format.html { redirect_to(vet_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
