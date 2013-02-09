# Report model
class Report < ActiveRecord::Base
  
  def self.animals_by(org, type)
    @animals_count = Animal.count(:conditions => {:organization_id => org})     
    @all_types = type.capitalize.constantize.all(:conditions => {:organization_id => org})
    @final_status_array = Array.new
    @final_status_hash_count = Hash.new
    @all_types.each do |object|
      @count = Animal.count(:conditions => {:organization_id => org, "#{type}_id".to_sym => object.id})
      @sub_hash = {"count" => @count.to_s, "percent" => ((@count.to_f / @animals_count.to_f) * 100)}
      @final_status_hash_count["#{object.report_display_name}"] = @sub_hash
      @final_status_array << ["#{object.report_display_name}", @sub_hash["percent"]]
    end
    @super_hash = {"pie" => @final_status_array, "bar" => @final_status_hash_count}
  end
  
end