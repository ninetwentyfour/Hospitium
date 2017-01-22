class ContactNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :noteable, polymorphic: true

  attr_accessible :note, :noteable_id, :noteable_type

  delegate :username, to: :user, allow_nil: true
end
