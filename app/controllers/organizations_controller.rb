class OrganizationsController < ApplicationController
  #caches_action :index, :expires_in => 1.minute
  #caches_action :show, :expires_in => 1.minute
  # GET /organizations
  # GET /organizations.xml
  def index
    #@organizations = Organization.all
    @organizations = Organization.find(:all, :conditions => {:id => current_user.organization_ids})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizations }
    end
  end

  # GET /organizations/1
  # GET /organizations/1.xml
  def show
    canonical_url("/organizations/#{params[:id]}")
    require_dependency "Organization"
    @organization = Rails.cache.fetch("public_org_#{params[:id]}", :expires_in => 15.minutes) do
      Organization.find_by_uuid(params[:id])
    end
    require_dependency "Animal"
    @animals = Rails.cache.fetch("public_org_animals_#{params[:id]}", :expires_in => 15.minutes) do
      Animal.find(:all, :conditions => {'public' => 1, :organization_id => @organization.id})
    end
    #@organization = Organization.find_by_uuid(params[:id])
    #@animals = Animal.find(:all, :conditions => {'public' => 1, :organization_id => @organization.id})
    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/new
  # GET /organizations/new.xml
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # POST /organizations
  # POST /organizations.xml
  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        format.html { redirect_to(@organization, :notice => 'Organization was successfully created.') }
        format.xml  { render :xml => @organization, :status => :created, :location => @organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.html { redirect_to(@organization, :notice => 'Organization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.xml
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(organizations_url) }
      format.xml  { head :ok }
    end
  end
end
