class Admin::Home::IndexPresenter
  def initialize(user)
    @user = user
    @animals_count = Animal.count(:conditions => {:organization_id => @user.organization_id}) 
    @animal_update = Animal.order("updated_at desc").where(:organization_id => @user.organization_id).first().try(:updated_at)
  end
  
  def final_status_hash
    Rails.cache.fetch("animal_status_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Report.animals_by(@user.organization_id, "status")
    end
  end
  
  def final_species_hash
    Rails.cache.fetch("animal_species_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Report.animals_by(@user.organization_id, "species")
    end
  end
  
  def latest_activity
    Rails.cache.fetch("latest_activity_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Event.find(:all, :conditions => {:organization_id => @user.organization_id}, :limit => 15, :order => "created_at desc")
    end
  end
  
  def public_animals
    Rails.cache.fetch("public_animals_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update}") do
      Animal.where(:organization_id => @user.organization_id, :public => 1).sort! { |a,b| b.impressions_count <=> a.impressions_count }
    end
  end
  
end