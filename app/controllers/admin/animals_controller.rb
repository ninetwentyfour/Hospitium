class Admin::AnimalsController < Admin::ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :xml, :json, :csv, :js
  
  # GET /animals
  # GET /animals.xml
  def index
    @search = Animal.select('animals.name, animals.microchip, animals.birthday, animals.uuid, animals.id, animals.status_id, animals.animal_color_id, animals.animal_sex_id, animals.species_id, animals.spay_neuter_id, animals.updated_at, animals.image, animals.image_file_name, animals.image_updated_at').
                    includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter).
                    organization(current_user).
                    search(params[:q])
    @animals = @search.result.paginate(:page => params[:page], :per_page => 10).order("name ASC")
    
    @presenter = Admin::Animals::IndexPresenter.new(current_user)
    
    respond_with(@animals) do |format|
      format.html
      format.csv { render :csv => Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :biter).organization(current_user).all,
                          :filename => 'animals' }
    end
  end

  # GET /animals/1
  # GET /animals/1.xml
  def show
    @animal = Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :shelter, :shots).find(params[:id])
    if @animal.documents.blank?
      @animal.documents.build
    end
    @presenter = Admin::Animals::ShowPresenter.new(current_user, @animal)
    respond_with(@animal)
  end

  # GET /animals/new
  # GET /animals/new.xml
  def new
    @animal = Animal.new
    @presenter = Admin::Animals::NewPresenter.new(current_user)
    
    respond_with(@animal)
  end

  # GET /animals/1/edit
  def edit
    @animal = Animal.find(params[:id])
  end

  # POST /animals
  # POST /animals.xml
  def create
    @animal = current_user.organization.animals.new(params[:animal])
    if @animal.save
      $statsd.increment 'animal.created'
      flash[:notice] = 'Animal was successfully created.'
    else
      flash[:error] = 'Animal was not successfully created.'
    end
    
    respond_with(@animal, :location => admin_animal_path(@animal))
  end
  
  def update
    @animal = Animal.find(params[:id])
    @animal.update_attributes(params[:animal])
    $statsd.increment 'animal.updated'
    respond_with(@animal, :location => admin_animal_path(@animal)) 
  end

  # DELETE /animals/1
  # DELETE /animals/1.xml
  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    $statsd.increment 'animal.deleted'
    flash[:notice] = 'Successfully destroyed animal.'
    
    respond_with(@animal, :location => admin_animals_path)
  end
  
  def duplicate
    new_record = Animal.find(params[:id]).dup
    if new_record.save
      $statsd.increment 'animal.duplicated'
      flash[:notice] = 'Successfully duplicated.'
    else
      flash[:error] = 'There was a problem duplicating.'
    end
    
    redirect_to :back
  end
  
  def cage_card
    @animal = Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :shelter).find(params[:id])

    respond_with(@animal) do |format|
      format.html {render :action => "cage_card", :layout => "cage_card"}
      format.xml  { render :xml => @animal }
    end
  end
  
  def qr_code
    @animal = Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter, :shelter).find(params[:id])

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

  def add_image
    @animal = Animal.find(params[:id])
    if @animal.update_attributes(params[:animal])
      flash[:notice] = 'Successfully added image.'
    else
      flash[:error] = @animal.errors.messages.first
    end
    redirect_to admin_animal_path(@animal)
  end
end
