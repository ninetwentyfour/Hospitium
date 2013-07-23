class Admin::ShotsController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :json, :csv

  # Allowed params for create and update
  self.permitted_attrs = [:name, :animal_id, :expires, :last_administered]
  # scope create to current_user.organization
  self.save_as_organization = true
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back
  
  # GET /shots
  # GET /shots.csv
  def index
    @presenter = Admin::Shots::IndexPresenter.new(current_user, params[:page], params[:q])
    respond_with(@shots) do |format|
      format.html
      format.csv { render :csv => Shot.includes(:animal).organization(current_user),
                          :filename => 'shots' }
    end
  end

  # GET /shots/1
  # GET /shots/1.xml
  def show
    @presenter = Admin::Shots::ShowPresenter.new(params[:id], current_user)

    respond_with(@shot)
  end
end