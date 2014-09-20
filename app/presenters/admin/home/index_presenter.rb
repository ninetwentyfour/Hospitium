class Admin::Home::IndexPresenter
  def initialize(user)
    @user = user
    @animals_count = Animal.where(:organization_id => @user.organization_id).count() 
    @animal_update = Animal.order("updated_at desc").where(:organization_id => @user.organization_id).first().try(:updated_at)

    @species_count = Species.where(:organization_id => @user.organization_id).count()

    @events_count = PublicActivity::Activity.where(:recipient_id => @user.organization_id).count() 
  end
  
  def status_chart
    Rails.cache.fetch("animal_status_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}") do
      Report.new_chart(@user.organization_id, "status")
    end
  end
  
  def species_chart
    Rails.cache.fetch("animal_species_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}_#{@species_count}") do
      Report.new_chart(@user.organization_id, "species")
    end
  end

  def colors_chart
    Rails.cache.fetch("animal_colors_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}") do
      Report.new_chart(@user.organization_id, "animal_color")
    end
  end
  
  def latest_activity
    Rails.cache.fetch("latest_activity_hash_user_#{@user.organization_id}_#{@events_count}") do
      PublicActivity::Activity.where(:recipient_id => @user.organization_id).order("created_at desc").limit(5).to_a
    end
  end
  
  def public_animals
    Rails.cache.fetch("public_animals_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}") do
      Animal.where(:organization_id => @user.organization_id, :public => 1).to_a.sort! { |a,b| b.impressions_count <=> a.impressions_count }
    end
  end

  def total_animals
    @animals_count
  end

  def total_species
    @species_count
  end

  def total_contacts
    Rails.cache.fetch("total_contacts_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}") do
      vet_contacts = VetContact.where(:organization_id => @user.organization_id).count() 
      volunteer_contacts = VolunteerContact.where(:organization_id => @user.organization_id).count() 
      adoption_contacts = AdoptionContact.where(:organization_id => @user.organization_id).count() 
      relinquishment_contacts = RelinquishmentContact.where(:organization_id => @user.organization_id).count()
      foster_contacts = FosterContact.where(:organization_id => @user.organization_id).count() 

      vet_contacts + volunteer_contacts + adoption_contacts + relinquishment_contacts + foster_contacts
    end
  end

  def total_events
    @events_count
  end

  def sex_chart
    Rails.cache.fetch("animal_sex_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}") do
      @final_status_array = []
      sex = {}
      sex[:male] = Animal.where(:organization_id => @user.organization_id, :animal_sex_id => 1).count()
      sex[:female] = Animal.where(:organization_id => @user.organization_id, :animal_sex_id => 2).count()
      sex[:unknown] = Animal.where(:organization_id => @user.organization_id, :animal_sex_id => 3).count()

      color = Paleta::Color.new(:hex, "7761a7")
      palette = Paleta::Palette.generate(:type => :analogous, :from => :color, :color => color, :size => 3)
      colors = palette.to_array(color_model = :hex)
      colors.shuffle!
      cnt = 0
      sex.each do |key, value|
        percent = ((value.to_f / @animals_count.to_f) * 100)
        @final_status_array << {:value => value, :color => "##{colors[cnt]}", :label => "#{key.capitalize}", :percent => percent}
        cnt += 1
      end

      @final_status_array
    end
  end

  def animals_sparkline
    Rails.cache.fetch("animal_sparkline_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}", :expires_in => 1.hour) do
      Report.item_per_day(@user.organization_id, "animal", 14)
    end
  end

  def species_sparkline
    Rails.cache.fetch("species_sparkline_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}_#{@species_count}", :expires_in => 1.hour) do
      Report.item_per_day(@user.organization_id, "species", 14)
    end
  end

  def contacts_sparkline
    Rails.cache.fetch("contact_sparkline_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}", :expires_in => 1.hour) do
      Report.contacts_per_day(@user.organization_id, 14)
    end
  end

  def events_sparkline
    Rails.cache.fetch("event_sparkline_hash_user_#{@user.organization_id}_#{@animals_count}_#{@animal_update.to_i}_#{@events_count}", :expires_in => 1.hour) do
      Report.item_per_day(@user.organization_id, "activity", 14, "`recipient_id`")
    end
  end
end