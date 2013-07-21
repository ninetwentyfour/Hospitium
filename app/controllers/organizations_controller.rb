class OrganizationsController < ApplicationController
  respond_to :html, :xml, :json

  # GET /organizations/1
  # GET /organizations/1.xml
  def show
    canonical_url("/organizations/#{params[:id]}")
    @organization = Rails.cache.fetch("public_org_#{params[:id]}", :expires_in => 15.minutes) do
      Organization.find_by_uuid(params[:id])
    end
    @animals = Rails.cache.fetch("public_org_animals_#{params[:id]}", :expires_in => 15.minutes) do
      # Animal.find(:all, :conditions => {'public' => 1, :organization_id => @organization.id})
      Animal.where('public' => 1, :organization_id => @organization.id)
    end
    
    respond_with(@organization)
  end

end
