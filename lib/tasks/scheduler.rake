# desc "This task is called by the Heroku scheduler add-on"
# task :count_animal_status => :environment do
#     @animals_count = Animal.count   
#     @all_statuses = Status.find(:all, :select => 'statuses.id, statuses.status')
#     @final_status_hash = Array.new
#     @final_status_hash_count = Hash.new
#     @all_statuses.each do |status|
#       @count = Animal.count(:conditions => {:status_id => status.id})
#       @sub_hash = Hash.new
#       @sub_hash["count"] = @count.to_s
#       @sub_hash["percent"] = (@count.to_f / @animals_count.to_f) * 100
#       #@final_status_hash["#{status.status}"] = @sub_hash
#       #@final_status_hash_count << ["#{status.status}", @count.to_s]
#       @final_status_hash_count["#{status.status}"] = @sub_hash
#       @final_status_hash << ["#{status.status}", (@count.to_f / @animals_count.to_f) * 100]
#     end
#     @super_hash = Hash.new
#     @super_hash["pie"] = @final_status_hash
#     @super_hash['bar'] = @final_status_hash_count
#     @super_hash['bar'].each do |key, value| 
# 				@status_count_log = AnimalStatusCount.new
# 				@status_count_log.count = value["count"]
# 				@status_count_log.status = key
# 				@status_count_log.save
# 		end
# end

task :send_reminders => :environment do
    Shot.send_reminders
end