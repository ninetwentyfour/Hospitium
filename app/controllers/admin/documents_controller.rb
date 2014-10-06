class Admin::DocumentsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :json, :js

  def index
    if params[:animal_id]
      @search = Document.organization(current_user).where(documentable_id: params[:animal_id], documentable_type: 'Animal').search(params[:q])
    else
      @search = Document.organization(current_user).search(params[:q])
    end
    @documents = @search.result.paginate(:page => params[:page], :per_page => 10).order("updated_at DESC")

    respond_with(@documents)
  end

  def create
    #loop on each file from array and create document
    params[:document][:filearrays].each do |file|
      @document = Document.new(:document => file, :documentable_id => params[:document][:documentable_id], :documentable_type => params[:document][:documentable_type], :organization_id => current_user.organization.id)
      if @document.save
        flash[:notice] = 'Successfully uploaded the document.'
      else
        flash[:error] = 'There was a problem uploading the document.'
      end
    end
    
    redirect_to :back
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    flash[:notice] = 'Successfully destroyed document.'
    
    redirect_to :back
  end

  private
    def document_params
      params.require(:document).permit(:document, :animal_id, :documentable_type, :documentable_id, :filearrays)
    end
end