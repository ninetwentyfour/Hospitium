class RelinquishAnimalsController < ApplicationController
  # POST /biters
  # POST /biters.xml
  def create
    @relinquish_animal = RelinquishAnimal.new(params[:relinquish_animal])

    respond_to do |format|
      if @relinquish_animal.save
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

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Animal successfully removed.') }
      format.xml  { head :ok }
    end
  end
end
