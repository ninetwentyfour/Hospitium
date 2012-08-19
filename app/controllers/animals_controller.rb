class AnimalsController < ApplicationController
  #caches_action :index, :cache_path => Proc.new { |controller| controller.params },:layout => false, :expires_in => 10.minutes
  
  respond_to :html, :xml, :json

  # GET /animals
  # GET /animals.xml
  def index
    canonical_url("/animals")
    #find animals that are public to show on animals for adoption page
    @animals = Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter).
                      where('public' => 1).
                      paginate(:page => params[:page], :per_page => 10).
                      order("updated_at DESC")

    respond_with(@animals)
  end

  # GET /animals/1
  # GET /animals/1.xml
  def show
    canonical_url("/animals/#{params[:id]}")
    @animal = Rails.cache.fetch("public_animal_#{params[:id]}", :expires_in => 15.minutes) do
      Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter).find_by_uuid!(params[:id])
    end

    if @animal.public == 1
      respond_with(@animal)
    else
      redirect_to "/animals/not_available", :status => 302
    end
  end
  
  def not_available
    canonical_url("/animals/not_available")
    @animals = Animal.where('public' => 1).
                      limit(5).
                      order("updated_at DESC")
    
    respond_with(@animals)
  end
  
end
