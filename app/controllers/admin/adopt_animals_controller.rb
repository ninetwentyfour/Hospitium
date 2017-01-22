class Admin::AdoptAnimalsController < Admin::CrudController
  load_and_authorize_resource :adopt_animal, find_by: :animal_id
  include PublicActivity::StoreController

  respond_to :html, :json

  # Allowed params for create and update
  self.permitted_attrs = [:adoption_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  def create
    @adopt_animal = AdoptAnimal.create(animal_id: adopt_animal_params[:animal_id], adoption_contact_id: adopt_animal_params[:adoption_contact_id])
    if adopt_animal_params[:adopted_date].present?
      animal = Animal.find(adopt_animal_params[:animal_id])
      animal.adopted_date = adopt_animal_params[:adopted_date]
      animal.save
      # @adopt_animal.adopted_date = adopt_animal_params[:adopted_date]
    end
    @adopt_animal.save
    flash[:success] = 'Adopt Animal was successfully created.'

    redirect_back(fallback_location: admin_adoption_contacts_path, notice: 'Adopt Animal was successfully created.')
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @adopt_animal = AdoptAnimal.find_by(animal_id: params[:id], adoption_contact_id: params[:adopt])
    @adopt_animal.destroy

    redirect_back(fallback_location: admin_adoption_contacts_path, notice: 'Animal successfully removed.')
  end

  private

  def adopt_animal_params
    params.require(:adopt_animal).permit(:adoption_contact_id, :animal_id, :adopted_date)
  end
end
