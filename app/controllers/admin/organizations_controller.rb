class Admin::OrganizationsController < Admin::ApplicationController
  load_and_authorize_resource
  include PublicActivity::StoreController
  
  respond_to :html, :json

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
    @organization.update_attributes(organization_params)
    
    flash[:success] = "Update successful"
    redirect_to :back
  end

  private
    def organization_params
      params.require(:organization).permit(:name, :phone_number, :address, :city, :state, :zip_code, :email, :website, :adoption_form, :volunteer_form, :relinquishment_form, :foster_form)
    end
end
