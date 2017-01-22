class Shot < ActiveRecord::Base
  include CommonScopes

  belongs_to :animal
  belongs_to :organization

  attr_accessible :name, :animal_id, :expires, :last_administered

  validates :name, :animal_id, presence: true

  def formatted_expires_date
    expires.blank? ? '' : expires.strftime('%a, %b %e at %l:%M')
  end

  def formatted_last_administered_date
    last_administered.blank? ? '' : last_administered.strftime('%a, %b %e at %l:%M')
  end

  # ===============
  # = CSV support =
  # ===============
  comma do
    id 'ID'
    name 'Name'
    animal 'Animal', &:name
    last_administered 'Last Administered'
    expires 'Expires'
  end

  # send email reminder for shots about to expire
  def self.send_reminders
    @shots = Shot.where('expires BETWEEN ? AND ?', 7.days.from_now.beginning_of_day, 7.days.from_now.end_of_day)
    @shots.each do |shot|
      ShotMailer.reminder_email(shot).deliver
    end
  end
end
