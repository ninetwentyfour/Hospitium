class Organization < ActiveRecord::Base
    has_paper_trail
    has_many :adoption_contacts
    has_many :animals
    has_many :animal_colors
    has_many :animal_weights
    has_many :facebook_accounts
    has_many :relinquishment_contacts
    has_many :shelters
    has_many :species
    has_many :twitter_accounts
    has_many :vet_contacts
    has_many :volunteer_contacts
    has_many :wordpress_accounts
    has_many :users
    before_create :create_uuid
    after_create :add_default_status
    #validates_presence_of :address, :city, :state, :zip_code
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
    
    #create the default statuses and assign them to the new organization
    def add_default_status
      @status = Status.new
      @status.update_attributes(:status => "Adoptable", :organization_id => self.id)
      @status = Status.new
      @status.update_attributes(:status => "New Intake", :organization_id => self.id)
      @status = Status.new
      @status.update_attributes(:status => "Sanctuary", :organization_id => self.id)
      @status = Status.new
      @status.update_attributes(:status => "Sick", :organization_id => self.id)
      @status = Status.new
      @status.update_attributes(:status => "Deceased", :organization_id => self.id)
      @status = Status.new
      @status.update_attributes(:status => "Adopted", :organization_id => self.id)
      @status = Status.new
      @status.update_attributes(:status => "Foster Care", :organization_id => self.id)
    end
    
end
