class Shelter < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "name ASC"
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def modify_phone_number
    unless self.phone.blank?
      self.phone = self.phone.delete("^0-9")
    end
  end
end
