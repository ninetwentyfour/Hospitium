class Shot < ActiveRecord::Base
  include CommonScopes

  before_create :create_uuid
  
  belongs_to :animal
  belongs_to :organization

  attr_accessible :name, :animal_id, :expires, :last_administered

  validates_presence_of :name, :animal_id

  def formatted_expires_date
    unless self.expires.blank?
      age = self.expires.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  def formatted_last_administered_date
    unless self.last_administered.blank?
      age = self.last_administered.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end

  # ===============
  # = CSV support =
  # ===============
  comma do
    id "ID"
    name "Name"
    animal "Animal" do |a| a.name end
    last_administered "Last Administered"
    expires "Expires"
  end

  # send email reminder for shots about to expire
  def self.send_reminders
    @shots = Shot.where('expires BETWEEN ? AND ?', 7.day.from_now.beginning_of_day, 7.day.from_now.end_of_day)
    @shots.each do |shot|
      ShotMailer.reminder_email(shot).deliver
    end
  end
end
