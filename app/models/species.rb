class Species < ActiveRecord::Base
  has_paper_trail
  default_scope :order => "name ASC"
  belongs_to :organization
  has_many :animals
  before_create :create_uuid
  
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
end
