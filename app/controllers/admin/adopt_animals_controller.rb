class Admin::AdoptAnimalsController < Admin::CrudController
  load_and_authorize_resource :adopt_animal, :find_by => :animal_id

  respond_to :html, :json

  # Allowed params for create and update
  self.permitted_attrs = [:adoption_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @adopt_animal = AdoptAnimal.find_by_animal_id_and_adoption_contact_id(params[:id], params[:adopt])
    @adopt_animal.destroy

    redirect_to(:back, :notice => 'Animal successfully removed.')
  end

  private
    def adopt_animal_params
      params.require(:adopt_animal).permit(:adoption_contact_id, :animal_id)
    end
end
