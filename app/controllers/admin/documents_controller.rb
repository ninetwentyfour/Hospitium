class Admin::DocumentsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :js
  
  # GET /documentDocument
  # GET /Documents.json
  def index
    @documents = Document.all
    
    respond_with(@documents)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_with(@document)
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_with(@document)
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])
    @document.save
    
    redirect_to :back
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])
    @document.update_attributes(params[:document])
    
    respond_with(@document)
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = document.find(params[:id])
    @document.destroy
    flash[:notice] = 'Successfully destroyed document.'
    
    redirect_to :back
  end
end