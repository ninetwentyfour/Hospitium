class Animal < ActiveRecord::Base
  include CommonScopes
  
  has_attached_file :image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, :bucket => 'hospitium-static', :styles => { :large => "530x530#", :medium => "260x180#", :thumb => "140x140#" }
  has_attached_file :second_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, :bucket => 'hospitium-static', :styles => { :large => "530x530#", :medium => "260x180#", :thumb => "140x140#" }
  has_attached_file :third_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, :bucket => 'hospitium-static', :styles => { :large => "530x530#", :medium => "260x180#", :thumb => "140x140#" }
  has_attached_file :fourth_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, :bucket => 'hospitium-static', :styles => { :large => "530x530#", :medium => "260x180#", :thumb => "140x140#" }
  
  belongs_to :organization
  belongs_to :species
  belongs_to :shelter
  belongs_to :animal_color
  belongs_to :animal_sex
  belongs_to :spay_neuter
  belongs_to :biter
  belongs_to :status
  
  has_many :animal_weights
  has_many :notes
  has_many :adopt_animals
  has_many :adoption_contacts, :through => :adopt_animals
  has_many :relinquish_animals
  has_many :relinquishment_contacts, :through => :relinquish_animals
  has_many :documents
  
  accepts_nested_attributes_for :documents
  
  
  before_create :create_uuid
  
  validates_presence_of :name, :date_of_intake, :organization, :species, :animal_color, :biter, :spay_neuter, :animal_sex, :status
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_content_type :second_image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_content_type :third_image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_content_type :fourth_image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  
  attr_accessible :name, :previous_name, :species_id, :special_needs, :diet, :date_of_intake, :date_of_well_check, :shelter_id, :deceased, 
    :deceased_reason, :adopted_date, :animal_color_id, :image, :second_image, :third_image, :fourth_image, :public, :birthday, :animal_sex_id, :spay_neuter_id,
    :biter_id, :status_id, :video_embed, :microchip, :documents_attributes
    
  delegate :name, :to => :species, :prefix => :species, :allow_nil => true
  delegate :name, :phone_number, :address, :city, :state, :zip_code, :website, :email, :to => :organization, :prefix => :organization, :allow_nil => true
  delegate :sex, :to => :animal_sex, :allow_nil => true
  delegate :spay, :to => :spay_neuter, :allow_nil => true
  delegate :color, :to => :animal_color, :allow_nil => true
  delegate :value, :to => :biter, :prefix => :biter, :allow_nil => true
  delegate :name, :to => :shelter, :prefix => :shelter, :allow_nil => true
  
  is_impressionable :counter_cache => true
  
  #set_primary_key :uuid
  def to_params
    "#{id}-#{uuid}"
  end
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def calculate_animal_age
    unless self.birthday.blank?
      age = (Time.now.year - self.birthday.year).to_s + " years"
      if age == "0 years"
        age = (Time.now.month - self.birthday.month).to_s + " months"
        if age == "0 months"
          age = (Time.now.day - self.birthday.day).to_s + " days"
        end
      end
    else
      age = ""
    end
    return age
  end
  
  def formatted_deceased_date
    self.formatted_date("deceased")
  end
  
  def formatted_intake_date
    self.formatted_date("date_of_intake")
  end
  
  def formatted_well_date
    self.formatted_date("date_of_well_check")
  end
  
  def formatted_adopted_date
    self.formatted_date("adopted_date")
  end
  
  def formatted_date(type)
    unless self.send(type).blank?
      age = self.send(type).strftime("%a, %b %e %Y")
    else
      age = ""
    end
    age
  end
  
  
  #define content for xml downloads
  def as_xls(options = {})
    $statsd.increment 'animal.xls_download'
    {
        "Id" => id.to_s,
        "Name" => name,
        "Previous Name" => previous_name,
        "Birthday" => birthday,
        "Species" => species["name"],
        "Animal Color" => animal_color["color"],
        "Spay / Neuter" => spay_neuter["spay"],
        "Biter" => biter["value"],
        "Sex" => animal_sex["sex"],
        "Public" => public,
        "Status" => status.try(:[], "status"),
        "Special Needs" => special_needs,
        "Diet" => diet,
        "Date of Well Check" => date_of_well_check,
        "Deceased Date" => deceased,
        "Deceased Reason" => deceased_reason,
        "Adopted Date" => adopted_date
    }
  end
  
end
