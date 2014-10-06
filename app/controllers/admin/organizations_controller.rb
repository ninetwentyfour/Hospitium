class Admin::OrganizationsController < Admin::ApplicationController
  load_and_authorize_resource
  skip_before_filter :authenticate_user_from_token!, :except => [:index, :show]
  # include PublicActivity::StoreController
  
  respond_to :html, :json

  def index
    @organizations = Organization.where(:id => current_user.organization_id)
    
    respond_with(@organizations)
  end
  
  def update
    @organization = Organization.where(:id => current_user.organization_id).first
    @organization.update_attributes(organization_params)
    
    flash[:success] = "Update successful"
    respond_with(@organization)
  end

  private
    def organization_params
      params.require(:organization).permit(:name, :phone_number, :address, :city, :state, :zip_code, :email, :website, :adoption_form, :volunteer_form, :relinquishment_form, :foster_form)
    end
end
