class Admin::VolunteerContactsController < Admin::CrudController
  load_and_authorize_resource
  include PublicActivity::StoreController

  respond_to :html, :json, :csv, :vcf

  # Allowed params for create and update
  self.permitted_attrs = [:first_name, :last_name, :address, :phone, :email, :application_date]
  # scope create to current_user.organization
  self.save_as_organization = true

  # GET /volunteer_contacts
  # GET /volunteer_contacts.xml
  def index
    @search = VolunteerContact.organization(current_user).search(params[:q])
    @volunteer_contacts = @search.result.paginate(page: params[:page], per_page: 10).order('updated_at DESC')

    respond_with(@volunteer_contacts) do |format|
      format.html # index.html.erb
      format.csv do
        render csv: VolunteerContact.organization(current_user),
               filename: 'volunteer_contacts'
      end
    end
  end
end
