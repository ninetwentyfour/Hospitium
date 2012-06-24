class Admin::AnimalsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /animals
  # GET /animals.xml
  def index
    @search = Animal.search(params[:search])
    @animals = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC", :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter], :select => 'animals.name, animals.microchip, animals.birthday, animals.uuid, animals.id, animals.status_id, animals.animal_color_id, animals.animal_sex_id, animals.spay_neuter_id, animals.updated_at, animals.image, animals.image_file_name, animals.image_updated_at')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animals }
      format.json  { render :json => @animals }
      format.xls { send_data Animal.find(:all, :conditions => {:organization_id => current_user.organization_id}).to_xls, content_type: 'application/vnd.ms-excel', filename: 'animals.xls' }
    end
  end

  # GET /animals/1
  # GET /animals/1.xml
  def show
    #require_dependency "Animal"
    @animal = Animal.find(params[:id], :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :shelter])
    @statuses = Status.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.status.to_s]}
    @species = Species.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.name.to_s]}
    @colors = AnimalColor.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.color.to_s]}
    @shelters = Shelter.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.name.to_s]}
    @animal_weights = AnimalWeight.find(:all, :conditions => {:animal_id => @animal.id}, :order => "date_of_weight ASC").map do |record|
          [ record.date_of_weight.strftime("%m/%d/%Y"), record.weight ]
    end
    @notes = Note.find(:all, :conditions => {:animal_id => @animal.id}, :include => [:user])

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
    @animal.organization_id = current_user.organization_id
    respond_to do |format|
      if @animal.save
        format.html { 
          flash[:notice] = 'Animal was successfully created.'
          redirect_to(:action => "show", :id => @animal.id.to_s+"-"+@animal.uuid, :only_path => true)
        }
        format.xml  { render :xml => @animal, :status => :created, :location => @animal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @animal = Animal.find(params[:id])

    respond_to do |format|
      if @animal.update_attributes(params[:animal])
        format.html { 
          flash[:notice] = 'Animal was successfully updated.'
          redirect_to(:action => "show", :id => @animal.id.to_s+"-"+@animal.uuid, :only_path => true)
        }
        format.json { respond_with_bip(@animal) }
      else
        flash[:notice] = 'There was a problem updating the animal.'
        redirect_to(:action => "show", :id => @animal.id.to_s+"-"+@animal.uuid, :only_path => true)
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
      format.html { redirect_to :back, notice: 'Successfully deleted.' }
      format.xml  { head :ok }
    end
  end
  
  def duplicate
    @existing_animal = Animal.find(params[:id])
    new_record = @existing_animal.dup
    respond_to do |format|
      if new_record.save
        format.html { redirect_to :back, notice: 'Successfully duplicated.' }
      else
        format.html { redirect_to :back, notice: 'There was a problem duplicating.' }
      end
    end
  end
  
  def cage_card
    #require_dependency "Animal"
    @animal = Animal.find(params[:id], :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :shelter])

    respond_to do |format|
      format.html {render :action => "cage_card", :layout => "cage_card"}
      format.xml  { render :xml => @animal }
    end
  end
  
  def qr_code
    #require_dependency "Animal"
    @animal = Animal.find(params[:id], :include => [:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :shelter])

    respond_to do |format|
      format.html {render :action => "qr_code", :layout => "qr_code"}
      format.svg { render :qrcode => "
        #{@animal.name}
        #{@animal.species_name}
        ----
        #{@animal.organization_name} 
        #{number_to_phone(@animal.organization_phone_number) unless @animal.organization_phone_number.blank?}
        #{@animal.organization_address unless @animal.organization_address.blank?}
        #{@animal.organization_city unless @animal.organization_city.blank?} #{@animal.organization_state unless @animal.organization_state.blank?} #{@animal.organization_zip_code unless @animal.organization_zip_code.blank?}", :level => :h, :unit => 6 }
    end
  end
end
