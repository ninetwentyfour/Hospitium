class Animal < ActiveRecord::Base
  has_paper_trail
  #default_scope :order => "name ASC"
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
      group :animal_weights do
        hide
      end
      exclude_fields :uuid, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :organization, :age, :sex
    end
    create do
      #exclude_fields :uuid
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
      # field :age do
      #   help 'Optional - age of the animal in years.'
      # end
      #field :sex, :enum
      field :animal_sex
      field :animal_color do
        help 'Required - if the animal color you need is not listed, click "Create animal color" above.'
      end
      #field :spay_neuter, :enum
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
      #field :age
      #field :sex, :enum
      field :animal_sex
      field :animal_color
      #field :spay_neuter, :enum
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
  
  #drop down options for some fields
  # def color_enum
  #    ['white', 'black', 'brown', 'gray', 'pink']
  # end
  
  def biter_enum
     ['No', 'Yes']
  end
  
  def spay_neuter_enum
     ['No', 'Yes']
  end
  
  def sex_enum
     ['Male', 'Female']
  end
  
  def status_enum
     ['Adoptable', 'New Intake', 'Sanctuary', 'Sick', 'Deceased', 'Adopted', 'Foster Care']
  end
  
  #age tracking code
  def self.calculate_age(birthday)
    Time.now.year - birthday.year
    #(Time.now.year - birthday.year) - (turned_older? ? 0 : 1) rescue 0
  end
 
  def next_birthday
    birthday.to_time.change(:year => (turned_older? ? 1.year.from_now : Time.now).year)
  end
 
  def turned_older?
    (birthday.to_time.change(:year => Time.now.year) <= Time.now)
  end
  
  
end
