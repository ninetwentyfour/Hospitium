class Admin::DocumentsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :js

  # POST /documents
  # POST /documents.json
  def create
    #loop on each file from array and create document
    params[:document][:filearrays].each do |file|
      @document = Document.new(:document => file, :documentable_id => params[:document][:documentable_id], :documentable_type => params[:document][:documentable_type])
      if @document.save
        flash[:notice] = 'Successfully uploaded the document.'
      else
        flash[:error] = 'There was a problem uploading the document.'
      end
    end
    
    redirect_to :back
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    flash[:notice] = 'Successfully destroyed document.'
    
    redirect_to :back
  end
end