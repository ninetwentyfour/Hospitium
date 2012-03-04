class Animal < ActiveRecord::Base
  CONSUMER_KEY = 'Is9pdOhRRNhx95wGBiWg'
  CONSUMER_SECRET = 'D2WLDX0Fh9EOGAhBJSQFkKs1U2c3ET2a5z2t9JZCrM'
  OPTIONS = {:site => "http://api.twitter.com", :request_endpoint => "http://api.twitter.com"}
  
  has_paper_trail
  has_attached_file :image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-test', :styles => { :large => "530x530>", :medium => "260x180#", :thumb => "140x140>" }
  has_attached_file :second_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-test', :styles => { :large => "530x530", :medium => "260x180#", :thumb => "140x140>" }
  has_attached_file :third_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-test', :styles => { :large => "530x530>", :medium => "260x180#", :thumb => "140x140>" }
  has_attached_file :fourth_image, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-test' || 'hospitium-static', :styles => { :large => "530x530", :medium => "260x180#", :thumb => "140x140>" }
  belongs_to :organization
  belongs_to :species
  belongs_to :shelter
  belongs_to :animal_color
  belongs_to :animal_sex
  belongs_to :spay_neuter
  belongs_to :biter
  belongs_to :status
  has_many :animal_weights
  has_many :adopt_animals
  has_many :adoption_contacts, :through => :adopt_animals
  has_many :relinquish_animals
  has_many :relinquishment_contacts, :through => :relinquish_animals
  
  
  before_create :create_uuid
  after_update :send_public_tweet
  validates_presence_of :name, :date_of_intake, :organization, :species, :animal_color, :biter, :spay_neuter, :animal_sex, :status
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']
  
  #set_primary_key :uuid
  def to_params
    "#{id}-#{uuid}"
  end
  
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def send_public_tweet
    if self.public == 1
      account = TwitterAccount.find_by_user_id(1)
      Twitter.configure do |config|
        config.consumer_key = TwitterAccount::CONSUMER_KEY
        config.consumer_secret = TwitterAccount::CONSUMER_SECRET
        config.oauth_token = account.oauth_token
        config.oauth_token_secret = account.oauth_token_secret
      end
      client = Twitter::Client.new
      #begin
      link = TwitterAccount.shorten_link("http://hospitium.co/animals/#{self.uuid}")
      client.update("#{self.name} is ready for adoption at #{link}")
      return true
    end
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
    unless self.deceased.blank?
      age = self.deceased.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  def formatted_intake_date
    unless self.date_of_intake.blank?
      age = self.date_of_intake.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  def formatted_well_date
    unless self.date_of_well_check.blank?
      age = self.date_of_well_check.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  
end
