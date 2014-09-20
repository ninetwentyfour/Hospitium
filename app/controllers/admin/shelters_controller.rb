class Admin::SheltersController < Admin::CrudController
  load_and_authorize_resource
  include PublicActivity::StoreController
  
  respond_to :html, :json, :csv

  # Allowed params for create and update
  self.permitted_attrs = [:name, :contact_first, :contact_last, :address, :phone, :email, :website, :notes]
  # scope create to current_user.organization
  self.save_as_organization = true
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back
  
  # GET /shelters
  # GET /shelters.xml
  def index
    @search = Shelter.includes(:animals).organization(current_user).search(params[:q])
    @shelters = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")
    respond_with(@shelters) do |format|
      format.html # index.html.erb
      format.csv { render :csv => Shelter.organization(current_user),
                          :filename => 'shelters' }
    end
  end
end
