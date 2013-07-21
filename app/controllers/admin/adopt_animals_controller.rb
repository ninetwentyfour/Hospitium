class Admin::AdoptAnimalsController < Admin::CrudController
  load_and_authorize_resource

  # Allowed params for create and update
  self.permitted_attrs = [:adoption_contact_id, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = false
  # redirect somewhere other than the object on create
  self.redirect_on_create = :back

  # # POST /biters
  # # POST /biters.xml
  # def create
  #   @adopt_animal = AdoptAnimal.new(adopt_animal_params)

  #   respond_to do |format|
  #     if @adopt_animal.save
  #       format.html { 
  #         redirect_to(:back, :notice => 'Animal successfully added.')
  #         #redirect_to(@species, :notice => 'Species was successfully created.') 
  #         }
  #       format.xml  { render :xml => @adopt_animal, :status => :created, :location => @adopt_animal }
  #     else
  #       format.html { render "new" }
  #       format.xml  { render :xml => @adopt_animal.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /biters/1
  # DELETE /biters/1.xml
  def destroy
    @adopt_animal = AdoptAnimal.find_by_animal_id_and_adoption_contact_id(params[:id], params[:adopt])
    @adopt_animal.destroy

    respond_to do |format|
      format.html { 
        redirect_to(:back, :notice => 'Animal successfully removed.')
        #redirect_to(@species, :notice => 'Species was successfully created.') 
        }
      format.xml  { head :ok }
    end
  end

  private
    def adopt_animal_params
      params.require(:adopt_animal).permit(:adoption_contact_id, :animal_id)
    end
end
