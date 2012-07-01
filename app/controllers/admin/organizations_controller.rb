class Admin::OrganizationsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json

  # GET /organizations
  # GET /organizations.xml
  def index
    @organizations = Organization.where(:id => current_user.organization_id)
    
    respond_with(@organizations)
  end

end
