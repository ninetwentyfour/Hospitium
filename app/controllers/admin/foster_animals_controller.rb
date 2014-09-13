class Admin::FosterAnimalsController < Admin::CrudController
  load_and_authorize_resource :foster_animal, :find_by => :animal_id

  respond_to :html, :json

  # Allowed params for create and update
  self.permitted_attrs = [:foster_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @adopt_animal = FosterAnimal.find_by_animal_id_and_foster_contact_id(params[:id], params[:foster])
    @adopt_animal.destroy

    redirect_to(:back, :notice => 'Animal successfully removed.')
  end

  private
    def foster_animal_params
      params.require(:foster_animal).permit(:foster_contact_id, :animal_id)
    end
end
