class Admin::NotesController < Admin::CrudController
  load_and_authorize_resource
  
  respond_to :html, :json, :js

  # Allowed params for create and update
  self.permitted_attrs = [:note, :animal_id]
  # scope create to current_user.organization
  self.save_as_organization = true
  # redirect somewhere other than the object on delete
  self.redirect_on_delete = :back

  def index
    if params[:animal_id]
      @search = Note.includes(:animal).where(animal_id: params[:animal_id]).search(params[:q])
    else  
      @search = Note.includes(:animal).where(user_id: current_user.id).search(params[:q])
    end
    @notes = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")

    respond_with(@notes)
  end

  def create
    @note = current_user.notes.new(note_params)
    @note.note = view_context.markdown(@note.note).gsub("\n","").gsub("\r","")
    @note.save
    $statsd.increment 'animal.note.created'
    respond_with(@note)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = 'Successfully destroyed note.'
    
    redirect_to :back
  end

  private
    def note_params
      params.require(:note).permit(permitted_attrs)
    end
end