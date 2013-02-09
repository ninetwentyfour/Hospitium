class Admin::HomeController < Admin::ApplicationController

  def index
    #generate the animal percentages for the dashboard
    @animals_count = Animal.count(:conditions => {:organization_id => current_user.organization_id}) 
    @animal_update = Animal.order("updated_at desc").where(:organization_id => current_user.organization_id).first().try(:updated_at)
    @final_status_hash = Rails.cache.fetch("animal_status_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      # Report.animals_by_status(current_user.organization_id)
      Report.animals_by(current_user.organization_id, "status")
    end
    @final_species_hash = Rails.cache.fetch("animal_species_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      #Report.animals_by_species(current_user.organization_id)
      Report.animals_by(current_user.organization_id, "species")
    end
    
    @latest_activity = Rails.cache.fetch("latest_activity_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Event.find(:all, :conditions => {:organization_id => current_user.organization_id}, :limit => 15, :order => "created_at desc")
    end

    @public_animals = Rails.cache.fetch("public_animals_hash_user_#{current_user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Animal.where(:organization_id => current_user.organization_id, :public => 1).sort! { |a,b| b.impressions_count <=> a.impressions_count }
    end
    
    # collect some stats for my dashbaord
    $statsd.gauge 'number_users', User.count
    $statsd.gauge 'number_animals', Animal.count
    $statsd.gauge 'number_organizations', Organization.count
    $statsd.gauge 'number_events', Event.count
  end
  
end