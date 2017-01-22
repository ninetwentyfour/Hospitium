class Admin::RelinquishAnimalsController < Admin::CrudController
  load_and_authorize_resource :relinquish_animal, find_by: :animal_id

  # Allowed params for create and update
  self.permitted_attrs = [:relinquishment_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false

  # # POST /biters
  # # POST /biters.xml
  def create
    @relinquish_animal = RelinquishAnimal.new(relinquish_animal_params)

    respond_to do |format|
      if @relinquish_animal.save!
        format.html do
          redirect_back(fallback_location: admin_relinquishment_contacts_path, notice: 'Animal successfully added.')
        end
        format.xml  { render xml: @relinquish_animal, status: :created, location: @relinquish_animal }
      else
        format.html { render 'new' }
        format.xml  { render xml: @relinquish_animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @relinquish_animal = RelinquishAnimal.find_by(animal_id: params[:id], relinquishment_contact_id: params[:relinquish])
    @relinquish_animal.destroy

    redirect_back(fallback_location: admin_relinquishment_contacts_path, notice: 'Animal successfully removed.')
  end

  private

  def relinquish_animal_params
    params.require(:relinquish_animal).permit(:relinquishment_contact_id, :animal_id)
  end
end
