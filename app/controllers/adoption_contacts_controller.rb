class AdoptionContactsController < ApplicationController
  # GET /adoption_contacts
  # GET /adoption_contacts.xml
  def index
    @adoption_contacts = AdoptionContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adoption_contacts }
    end
  end

  # GET /adoption_contacts/1
  # GET /adoption_contacts/1.xml
  def show
    @adoption_contact = AdoptionContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adoption_contact }
    end
  end

  # GET /adoption_contacts/new
  # GET /adoption_contacts/new.xml
  def new
    @adoption_contact = AdoptionContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adoption_contact }
    end
  end

  # GET /adoption_contacts/1/edit
  def edit
    @adoption_contact = AdoptionContact.find(params[:id])
  end

  # POST /adoption_contacts
  # POST /adoption_contacts.xml
  def create
    @adoption_contact = AdoptionContact.new(params[:adoption_contact])

    respond_to do |format|
      if @adoption_contact.save
        format.html { redirect_to(@adoption_contact, :notice => 'Adoption contact was successfully created.') }
        format.xml  { render :xml => @adoption_contact, :status => :created, :location => @adoption_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adoption_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adoption_contacts/1
  # PUT /adoption_contacts/1.xml
  def update
    @adoption_contact = AdoptionContact.find(params[:id])

    respond_to do |format|
      if @adoption_contact.update_attributes(params[:adoption_contact])
        format.html { redirect_to(@adoption_contact, :notice => 'Adoption contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adoption_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adoption_contacts/1
  # DELETE /adoption_contacts/1.xml
  def destroy
    @adoption_contact = AdoptionContact.find(params[:id])
    @adoption_contact.destroy

    respond_to do |format|
      format.html { redirect_to(adoption_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
