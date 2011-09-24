class Organization < ActiveRecord::Base
    has_paper_trail
    has_and_belongs_to_many :users
    before_create :create_uuid
    validates_presence_of :address, :city, :state, :zip_code
    validates_uniqueness_of :name
    
    # settings for rails admin views
    rails_admin do
      show do
        exclude_fields :uuid
      end
      create do
        exclude_fields :uuid
      end
      edit do
        exclude_fields :uuid
      end
      list do
        exclude_fields :uuid
      end
    end
    
    #create uuid
    def create_uuid()
      self.uuid = UUIDTools::UUID.random_create.to_s
    end
    
end
