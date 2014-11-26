class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :animal

  attr_accessible :note, :animal_id
  
  delegate :username, to: :user, allow_nil: true
end
