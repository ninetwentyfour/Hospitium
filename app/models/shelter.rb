class Shelter < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "name ASC"
  belongs_to :organization
  before_create :create_uuid, :modify_phone_number
  before_update :modify_phone_number
  
  # settings for rails admin views
  # rails_admin do
  #   show do
  #     exclude_fields :uuid, :organization
  #   end
  #   create do
  #     exclude_fields :uuid
  #   end
  #   edit do
  #     exclude_fields :uuid
  #   end
  #   list do
  #     exclude_fields :uuid, :organization
  #   end
  # end
  
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
