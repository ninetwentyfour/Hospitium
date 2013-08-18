class Admin::RelinquishAnimalsController < Admin::CrudController
  load_and_authorize_resource :relinquish_animal, :find_by => :animal_id

  # Allowed params for create and update
  self.permitted_attrs = [:relinquishment_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  # # POST /biters
  # # POST /biters.xml
  def create
    @relinquish_animal = RelinquishAnimal.new(relinquish_animal_params)

    respond_to do |format|
      if @relinquish_animal.save!
        format.html { 
          redirect_to(:back, :notice => 'Animal successfully added.')
          }
        format.xml  { render :xml => @relinquish_animal, :status => :created, :location => @relinquish_animal }
      else
        format.html { render "new" }
        format.xml  { render :xml => @relinquish_animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @relinquish_animal = RelinquishAnimal.find_by_animal_id_and_relinquishment_contact_id(params[:id], params[:relinquish])
    @relinquish_animal.destroy

    redirect_to(:back, :notice => 'Animal successfully removed.')
  end

  private
    def relinquish_animal_params
      params.require(:relinquish_animal).permit(:relinquishment_contact_id, :animal_id)
    end
end
