class Admin::OrganizationsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json

  # GET /organizations
  # GET /organizations.xml
  def index
    @organizations = Organization.where(:id => current_user.organization_id)
    
    respond_with(@organizations)
  end
  
  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @organization = Organization.find(params[:id])
    @organization.update_attributes(params[:organization])
    
    respond_with(@organization, :location => admin_organizations_path)
  end

end
