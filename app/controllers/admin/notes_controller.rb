class Admin::NotesController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :js

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.new(params[:note])
    @note.note = view_context.markdown(@note.note).gsub("\n","").gsub("\r","")
    @note.save
    $statsd.increment 'animal.note.created'
    respond_with(@note)
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = 'Successfully destroyed note.'
    
    redirect_to :back
  end
end