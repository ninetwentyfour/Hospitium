# Report model
class Report < ActiveRecord::Base
  
  def self.animals_by_status(org)
    #generate the animal status percentages
    @animals_count = Animal.count(:conditions => {:organization_id => org})     
    @all_statuses = Status.find(:all, :select => 'statuses.id, statuses.status', :conditions => {:organization_id => org})
    @final_status_hash = Array.new
    @final_status_hash_count = Hash.new
    @all_statuses.each do |status|
      @count = Animal.count(:conditions => {:organization_id => org, :status_id => status.id})
      @sub_hash = Hash.new
      @sub_hash["count"] = @count.to_s
      @sub_hash["percent"] = (@count.to_f / @animals_count.to_f) * 100
      #@final_status_hash["#{status.status}"] = @sub_hash
      #@final_status_hash_count << ["#{status.status}", @count.to_s]
      @final_status_hash_count["#{status.status}"] = @sub_hash
      @final_status_hash << ["#{status.status}", (@count.to_f / @animals_count.to_f) * 100]
    end
    @super_hash = Hash.new
    @super_hash["pie"] = @final_status_hash
    @super_hash['bar'] = @final_status_hash_count
    return @super_hash
  end
  
  def self.animals_by_species(org)
    #generate the animal species percentages
    @animals_count = Animal.count(:conditions => {:organization_id => org})     
    @all_species = Species.find(:all, :select => 'species.id, species.name', :conditions => {:organization_id => org})
    @final_species_hash = Array.new
    @final_species_hash_count = Hash.new
    @all_species.each do |species|
      @count = Animal.count(:conditions => {:organization_id => org, :species_id => species.id})
      @sub_hash = Hash.new
      @sub_hash["count"] = @count.to_s
      @sub_hash["percent"] = (@count.to_f / @animals_count.to_f) * 100
      #@final_species_hash["#{species.name}"] = @sub_hash
      @final_species_hash_count["#{species.name}"] = @sub_hash
      @final_species_hash << ["#{species.name}", (@count.to_f / @animals_count.to_f) * 100]
    end
    @super_hash = Hash.new
    @super_hash["pie"] = @final_species_hash 
    @super_hash['bar'] = @final_species_hash_count
    return @super_hash
  end
  
end