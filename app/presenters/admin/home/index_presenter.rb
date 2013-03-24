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

  def total_animals
    @animals_count
  end

  def total_species
    Species.count(:conditions => {:organization_id => @user.organization_id}) 
  end

  def total_contacts
    vet_contacts = VetContact.count(:conditions => {:organization_id => @user.organization_id}) 
    volunteer_contacts = VolunteerContact.count(:conditions => {:organization_id => @user.organization_id}) 
    adoption_contacts = AdoptionContact.count(:conditions => {:organization_id => @user.organization_id}) 
    relinquishment_contacts = RelinquishmentContact.count(:conditions => {:organization_id => @user.organization_id})

    vet_contacts + volunteer_contacts + adoption_contacts + relinquishment_contacts
  end

  def total_events
    Event.count(:conditions => {:organization_id => @user.organization_id}) 
  end

  def animals_by_sex
    @final_status_array = []
    sex = {}
    sex[:male] = Animal.count(:conditions => {:organization_id => @user.organization_id, :animal_sex_id => 1})
    sex[:female] = Animal.count(:conditions => {:organization_id => @user.organization_id, :animal_sex_id => 2})
    sex[:unknown] = Animal.count(:conditions => {:organization_id => @user.organization_id, :animal_sex_id => 3})

    color = Paleta::Color.new(:hex, "d63a4c")
    palette = Paleta::Palette.generate(:type => :analogous, :from => :color, :color => color, :size => 3)
    cnt = 0
    sex.each do |key, value|
      percent = ((value.to_f / @animals_count.to_f) * 100)
      @final_status_array << {:value => value, :color => "##{palette[cnt].hex}", :label => "#{key.capitalize}", :percent => percent}
      cnt += 1
    end

    @final_status_array
  end
end