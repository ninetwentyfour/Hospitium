class Admin::ContactNotesController < Admin::CrudController
  load_and_authorize_resource

  respond_to :html, :json, :js

  # Allowed params for create and update
  self.permitted_attrs = [:note, :noteable_id, :noteable_type]
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
    @notes = @search.result.paginate(page: params[:page], per_page: 10).order('updated_at DESC')

    respond_with(@notes)
  end

  def create
    @note = current_user.contact_notes.new(note_params)
    @note.organization_id = current_user.organization_id
    @note.note = view_context.markdown(@note.note).delete("\n").delete("\r")
    @note.save
    # AnimalsChannel.broadcast_to(@note.animal, @note)
    # ActionCable.server.broadcast 'messages',
    #   message: @note.to_json,
    #   user: current_user.username
    ActionCable.server.broadcast "notes_#{@note.noteable_id}",
                                 record: @note.to_json,
                                 user: current_user.username
    # $statsd.increment 'animal.note.created'
    respond_with(@note)
  end

  def destroy
    @note = ContactNote.find(params[:id])
    @note.destroy
    flash[:notice] = 'Successfully destroyed note.'

    redirect_back(fallback_location: admin_animals_path)
  end

  private

  def note_params
    params.require(:contact_note).permit(permitted_attrs).merge(organization_id: current_user.organization_id)
  end
end
