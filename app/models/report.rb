# Report model
class Report < ActiveRecord::Base
  def self.new_chart(org, type)
    @animals_count = Animal.count(:conditions => {:organization_id => org})     
    @all_types = type.camelize.constantize.all(:conditions => {:organization_id => org})
    @final_status_array = Array.new

    color = Paleta::Color.new(:hex, "d63a4c")
    palette = Paleta::Palette.generate(:type => :analogous, :from => :color, :color => color, :size => @all_types.count)

    @all_types.each_with_index do |object, index|
      @count = Animal.count(:conditions => {:organization_id => org, "#{type}_id".to_sym => object.id})
      percent = ((@count.to_f / @animals_count.to_f) * 100)
      @final_status_array << {:value => @count, :color => "##{palette[index].hex}", :label => "#{object.report_display_name}", :percent => percent}
    end
    @final_status_array
  end

  def self.item_per_day(org, item, days_past)
    date = Date.today - days_past.to_i

    items = item.camelize.constantize.where("organization_id = ? and date(created_at) > ?", org, date).group("date(created_at)").count

    # fill empty dates with 0s
    date.upto(Date.today) do |x|
      items[x] ||= 0
    end

    sorted = items.sort_by { |date, value| date }
    sorted.map! {|array| array[1] }
    sorted
  end

  def self.contacts_per_day(org, days_past)
    set = [0]
    set = set.cycle.take days_past.to_i+1
    %w(vet_contact volunteer_contact adoption_contact relinquishment_contact).each do |item|
      results = item_per_day(org, item, days_past)
      set = set.map.with_index{ |m,i| m + results[i].to_i }
    end
    set
    # date = Date.today - days_past.to_i

    # vet_contacts = VetContact.where("organization_id = ? and date(created_at) > ?", org, date).group("date(created_at)").count
    # date.upto(Date.today) do |x|
    #   vet_contacts[x] ||= 0
    # end
    # vet_sorted = vet_contacts.sort_by { |date, value| date }
    # vet_sorted.map! {|array| array[1] }

    # volunteer_contacts = VolunteerContact.where("organization_id = ? and date(created_at) > ?", org, date).group("date(created_at)").count
    # date.upto(Date.today) do |x|
    #   volunteer_contacts[x] ||= 0
    # end
    # volunteer_sorted = volunteer_contacts.sort_by { |date, value| date }
    # volunteer_sorted.map! {|array| array[1] }

    # adoption_contacts = AdoptionContact.where("organization_id = ? and date(created_at) > ?", org, date).group("date(created_at)").count
    # date.upto(Date.today) do |x|
    #   adoption_contacts[x] ||= 0
    # end
    # adoption_sorted = adoption_contacts.sort_by { |date, value| date }
    # adoption_sorted.map! {|array| array[1] }

    # relinquishment_contacts = RelinquishmentContact.where("organization_id = ? and date(created_at) > ?", org, date).group("date(created_at)").count
    # date.upto(Date.today) do |x|
    #   relinquishment_contacts[x] ||= 0
    # end
    # relinquishment_sorted = relinquishment_contacts.sort_by { |date, value| date }
    # relinquishment_sorted.map! {|array| array[1] }

    # total = vet_sorted.map.with_index{ |m,i| m + volunteer_sorted[i].to_i }
    # total = total.map.with_index{ |m,i| m + adoption_sorted[i].to_i }
    # total = total.map.with_index{ |m,i| m + relinquishment_sorted[i].to_i }
    # total
  end
end