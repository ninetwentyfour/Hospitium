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
  has_many :documents, :as => :documentable
  has_many :shots
  
  
  before_create :create_uuid

  attr_accessible :name, :previous_name, :species_id, :special_needs, :diet, :date_of_intake, :date_of_well_check, :shelter_id, :deceased, 
    :deceased_reason, :adopted_date, :animal_color_id, :image, :second_image, :third_image, :fourth_image, :public, :birthday, :animal_sex_id, :spay_neuter_id,
    :biter_id, :status_id, :video_embed, :microchip
  
  validates_presence_of :name, :date_of_intake, :organization, :species, :animal_color, :biter, :spay_neuter, :animal_sex, :status
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_content_type :second_image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_content_type :third_image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_content_type :fourth_image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  validates_attachment_size :image, :less_than => 4.megabytes
  validates_attachment_size :second_image, :less_than => 4.megabytes
    
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

  # ===============
  # = CSV support =
  # ===============
  comma do
    id "ID"
    name "Name"
    previous_name "Previous Name"
    birthday "Birthday"
    species "Species" do |species| species.name end
    animal_color "Animal Color" do |ac| ac.color end
    spay_neuter "Spay / Neuter" do |sn| sn.spay end
    biter "Biter" do |b| b.value end
    animal_sex "Sex" do |s| s.sex end
    public "Public" do |p| p == 1 ? "yes" : "no" end
    status "Status" do |s| s.try(:status) end
    special_needs "Special Needs"
    diet "Diet"
    date_of_well_check "Date of Well Check"
    deceased "Deceased Date"
    deceased_reason "Deceased Reason"
    adopted_date "Adopted Date"
  end
  
end
