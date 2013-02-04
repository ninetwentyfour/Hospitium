class Admin::NotesController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :js
  
  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
    
    respond_with(@notes)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_with(@note)
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_with(@note)
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.new(params[:note])
    @note.note = view_context.markdown(@note.note).gsub("\n","").gsub("\r","")
    @note.save
    $statsd.increment 'animal.note.created'
    respond_with(@note)
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note])
    
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