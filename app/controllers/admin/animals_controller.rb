class Admin::AnimalsController < Admin::ApplicationController

  #layout "admin/application"
  # GET /animals
  # GET /animals.xml
  def index

    #@animals = Animal.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC", :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter])
    @search = Animal.search(params[:search])
    #@animals = @search.relation.where(:organization_id => current_user.organization_id)   # or @search.relation to lazy load in view
    @animals = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC", :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter])


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animals }
      format.json  { render :json => @animals }
    end
  end

  # GET /animals/1
  # GET /animals/1.xml
  def show
    require_dependency "Animal"
    @animal = Animal.find_by_uuid(params[:id])
    @statuses = Status.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.status.to_s]}
    @species = Species.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.name.to_s]}
    @colors = AnimalColor.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.color.to_s]}
    @shelters = Shelter.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.name.to_s]}
    @animal_weights = AnimalWeight.find(:all, :conditions => {:animal_id => @animal.id}, :order => "date_of_weight ASC")
    
    @status = Status.new
    @species_model = Species.new
    @animal_color_model = AnimalColor.new
    @shelter_model = Shelter.new
    @animal_weight_model = AnimalWeight.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @animal }
    end
  end

  # GET /animals/new
  # GET /animals/new.xml
  def new
    @animal = Animal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @animal }
    end
  end

  # GET /animals/1/edit
  def edit
    @animal = Animal.find(params[:id])
  end

  # POST /animals
  # POST /animals.xml
  def create
    @animal = Animal.new(params[:animal])

    respond_to do |format|
      if @animal.save
        format.html { redirect_to(@animal, :notice => 'Animal was successfully created.') }
        format.xml  { render :xml => @animal, :status => :created, :location => @animal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animals/1
  # PUT /animals/1.xml
  # def update
  #   @animal = Animal.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @animal.update_attributes(params[:animal])
  #       format.html { redirect_to(@animal, :notice => 'Animal was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @animal.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  
  def update
    #@animal = Animal.find(params[:id])
    @animal = Animal.find_by_uuid(params[:id])

    respond_to do |format|
      if @animal.update_attributes(params[:animal])
        format.html { 
          #redirect_to(@animal.uuid, :notice => 'Animal was successfully updated.')
          flash[:notice] = 'Animal was successfully updated.'
          redirect_to(:action => "show", :id => @animal.uuid)
        }
        format.json { respond_with_bip(@animal) }
      else
        #format.html { render :action => "edit" }
        flash[:notice] = 'There was a problem updating the animal.'
        redirect_to(:action => "show", :id => @animal.uuid)
        format.json { respond_with_bip(@animal) }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.xml
  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy

    respond_to do |format|
      format.html { redirect_to(animals_url) }
      format.xml  { head :ok }
    end
  end
end
