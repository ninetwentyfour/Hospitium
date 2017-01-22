class Admin::StatusesController < Admin::CrudController
  load_and_authorize_resource
  # include PublicActivity::StoreController

  # Allowed params for create and update
  self.permitted_attrs = [:status]
  # scope create to current_user.organization
  self.save_as_organization = true
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  # GET /statuses
  # GET /statuses.xml
  def index
    @search = Status.includes(:animals).organization(current_user).search(params[:q])
    @statuses = @search.result.paginate(page: params[:page], per_page: 10).order('updated_at DESC')

    respond_with(@statuses)
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])
    @animals = Animal.where(status_id: @status.id).order('name ASC')

    respond_with(@status)
  end
end
