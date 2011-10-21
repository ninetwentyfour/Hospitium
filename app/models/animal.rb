class Animal < ActiveRecord::Base
  has_paper_trail
  has_attached_file :image, :storage => :s3, :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-static', :styles => { :large => "900x900>", :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :organization
  belongs_to :species
  belongs_to :shelter
  belongs_to :animal_color
  belongs_to :animal_sex
  belongs_to :spay_neuter
  belongs_to :biter
  belongs_to :status
  has_many :animal_weights
  has_one :relinquishment_contact
  
  before_create :create_uuid
  
  validates_presence_of :name, :date_of_intake, :organization, :species, :animal_color, :biter, :spay_neuter, :animal_sex, :status
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  
  # settings for rails admin views
  rails_admin do
    show do
      field :name
      field :previous_name
      field :status
      field :public
      field :species
      field :birthday
      field :animal_sex
      field :animal_color
      field :spay_neuter
      field :biter
      field :date_of_intake
      field :date_of_well_check
      field :organization
      field :shelter
      field :special_needs
      field :diet
      field :adopted_date
      field :deceased
      field :deceased_reason
    end
    create do
      field :name do
        help 'Required - the animals current name.'
      end
      field :previous_name do
        help 'Optional - any previous names the animal may have had.'
      end
      field :status
      field :public, :boolean do
        help 'Optional - check to make the animal appear on our adopt list.'
      end
      field :species do
        help 'Required - if the species you need is not listed, click "Create species" above.'
      end
      field :birthday
      field :animal_sex
      field :animal_color do
        help 'Required - if the animal color you need is not listed, click "Create animal color" above.'
      end
      field :spay_neuter
      field :biter
      field :date_of_intake
      field :date_of_well_check do
        help 'Optional - date of first vet visit.'
      end
      field :organization
      field :shelter do
        help 'Optional - if the shelter you need is not listed, click "Create shelter" above.'
      end
      field :special_needs
      field :diet
      field :adopted_date
      field :deceased
      field :deceased_reason
      field :image, :paperclip_file
      group :animal_weights
    end
    edit do
      field :name
      field :previous_name
      field :status
      field :public, :boolean
      field :species
      field :birthday
      field :animal_sex
      field :animal_color
      field :spay_neuter
      field :biter
      field :date_of_intake
      field :date_of_well_check
      field :organization
      field :shelter
      field :special_needs
      field :diet
      field :adopted_date
      field :deceased
      field :deceased_reason
      field :image, :paperclip_file
      group :animal_weights
    end
    list do
      exclude_fields :uuid, :age, :sex
    end
  end
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  
  
end
