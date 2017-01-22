class Admin::FosterAnimalsController < Admin::CrudController
  load_and_authorize_resource :foster_animal, find_by: :animal_id
  include PublicActivity::StoreController

  respond_to :html, :json

  # Allowed params for create and update
  self.permitted_attrs = [:foster_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  def create
    @foster_animal = FosterAnimal.create(animal_id: foster_animal_params[:animal_id], foster_contact_id: foster_animal_params[:foster_contact_id])
    if foster_animal_params[:fostered_date].present?
      animal = Animal.find(foster_animal_params[:animal_id])
      animal.fostered_date = foster_animal_params[:fostered_date]
      animal.save
    end
    @foster_animal.save
    flash[:success] = 'Foster Animal was successfully created.'

    redirect_back(fallback_location: admin_foster_contacts_path)
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @adopt_animal = FosterAnimal.find_by(animal_id: params[:id], foster_contact_id: params[:foster])
    @adopt_animal.destroy

    redirect_back(fallback_location: admin_foster_contacts_path, notice: 'Animal successfully removed.')
  end

  private

  def foster_animal_params
    params.require(:foster_animal).permit(:foster_contact_id, :animal_id, :fostered_date)
  end
end
