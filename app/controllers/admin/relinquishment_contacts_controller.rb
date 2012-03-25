class Admin::RelinquishmentContactsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /relinquishment_contacts
  # GET /relinquishment_contacts.xml
  def index
    @search = RelinquishmentContact.search(params[:search])
    @relinquishment_contacts = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relinquishment_contacts }
      format.xls { send_data RelinquishmentContact.find(:all, :conditions => {:organization_id => current_user.organization_id}).to_xls, content_type: 'application/vnd.ms-excel', filename: 'relinquishment_contacts.xls' }
    end
  end

  # GET /relinquishment_contacts/1
  # GET /relinquishment_contacts/1.xml
  def show
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
    @animals = RelinquishmentContact.find(params[:id]).animals
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relinquishment_contact }
    end
  end

  # GET /relinquishment_contacts/new
  # GET /relinquishment_contacts/new.xml
  def new
    @relinquishment_contact = RelinquishmentContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relinquishment_contact }
    end
  end

  # GET /relinquishment_contacts/1/edit
  def edit
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
  end

  # POST /relinquishment_contacts
  # POST /relinquishment_contacts.xml
  def create
    @relinquishment_contact = RelinquishmentContact.new(params[:relinquishment_contact])
    @relinquishment_contact.organization_id = current_user.organization_id
    respond_to do |format|
      if @relinquishment_contact.save
        format.html { redirect_to(@relinquishment_contact, :notice => 'Relinquishment contact was successfully created.') }
        format.xml  { render :xml => @relinquishment_contact, :status => :created, :location => @relinquishment_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @relinquishment_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /relinquishment_contacts/1
  # PUT /relinquishment_contacts/1.xml
  def update
    @relinquishment_contact = RelinquishmentContact.find(params[:id])

    respond_to do |format|
      if @relinquishment_contact.update_attributes(params[:relinquishment_contact])
        format.html { redirect_to(@relinquishment_contact, :notice => 'Relinquishment contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relinquishment_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /relinquishment_contacts/1
  # DELETE /relinquishment_contacts/1.xml
  def destroy
    @relinquishment_contact = RelinquishmentContact.find(params[:id])
    @relinquishment_contact.destroy

    respond_to do |format|
      format.html { redirect_to(relinquishment_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
