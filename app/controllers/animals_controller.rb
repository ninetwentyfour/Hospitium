class AnimalsController < ApplicationController  
  respond_to :html, :json

  def index
    canonical_url("/animals")
    
    @animals = Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter).
                      where('public' => 1).
                      paginate(:page => params[:page], :per_page => 10).
                      order("updated_at DESC").to_a.shuffle!
    
    # only show animals from orgs that have contact info
    @animals.select! {|animal| animal.organization.has_info? }
    respond_with(@animals)
  end

  def show
    canonical_url("/animals/#{params[:id]}")
    @animal = Rails.cache.fetch("public_animal_#{params[:id]}", :expires_in => 15.minutes) do
      Animal.includes(:animal_color, :animal_sex, :species, :status, :organization, :spay_neuter).find(params[:id])
    end

    if @animal.public == 1
      impressionist(@animal, nil, :unique => [:session_hash])
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
