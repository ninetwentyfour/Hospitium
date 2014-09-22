class Organization < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  # include PublicActivity::Model
  # tracked owner: -> controller, model { controller.current_user }, 
  #         recipient: -> controller, model { controller.current_user.organization }, 
  #         params: {
  #           author_name: -> controller, model { controller.current_user.username },
  #           author_email: -> controller, model { controller.current_user.email },
  #           object_name: -> controller, model { model.name },
  #           summary: -> controller, model { model.changes }
  #         }

  has_attached_file :adoption_form, 
                    :default_url => "https://d4uktpxr9m70.cloudfront.net/pdfs/Adoption-Form.pdf", 
                    :storage => :s3, 
                    :s3_protocol => "https", 
                    :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, 
                    :bucket => 'hospitium-static', 
                    :url => "/system/:hash/:filename", 
                    :hash_secret => ENV['SALTY']
  has_attached_file :volunteer_form, 
                    :default_url => "https://d4uktpxr9m70.cloudfront.net/pdfs/Volunteer-Application.pdf", 
                    :storage => :s3, 
                    :s3_protocol => "https", 
                    :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, 
                    :bucket => 'hospitium-static', 
                    :url => "/system/:hash/:filename", 
                    :hash_secret => ENV['SALTY']
  has_attached_file :relinquishment_form, 
                    :storage => :s3, 
                    :s3_protocol => "https", 
                    :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, 
                    :bucket => 'hospitium-static', 
                    :url => "/system/:hash/:filename", 
                    :hash_secret => ENV['SALTY']
  has_attached_file :foster_form, 
                    :storage => :s3, 
                    :s3_protocol => "https", 
                    :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}, 
                    :bucket => 'hospitium-static', 
                    :url => "/system/:hash/:filename", 
                    :hash_secret => ENV['SALTY']
  validates_attachment_content_type :adoption_form, :content_type => ['application/pdf', 
                                                                      'application/msword', 
                                                                      'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 
                                                                      'application/vnd.openxmlformats-officedocument.wordprocessingml.template']
  
  has_many :adoption_contacts, :dependent => :destroy
  has_many :animals, :dependent => :destroy
  has_many :animal_colors, :dependent => :destroy
  has_many :animal_weights, :dependent => :destroy
  has_many :facebook_accounts, :dependent => :destroy
  has_many :relinquishment_contacts, :dependent => :destroy
  has_many :shelters, :dependent => :destroy
  has_many :shots, :dependent => :destroy
  has_many :species, :dependent => :destroy
  has_many :statuses, :dependent => :destroy
  has_many :twitter_accounts, :dependent => :destroy
  has_many :vet_contacts, :dependent => :destroy
  has_many :volunteer_contacts, :dependent => :destroy
  has_many :wordpress_accounts, :dependent => :destroy
  has_many :foster_contacts, :dependent => :destroy
  has_many :users, :dependent => :destroy
  
  before_create :create_uuid
  before_update :modify_phone_number
  after_create :add_default_status, :add_default_animal_colors, :add_default_species

  attr_accessible :name, :phone_number, :address, :city, :state, :zip_code, :email, :website, :adoption_form, :volunteer_form, :relinquishment_form, :foster_form

  validates_uniqueness_of :name
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  #create the default statuses and assign them to the new organization
  def add_default_status
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "Adoptable")
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "New Intake")
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "Sanctuary")
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "Sick")
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "Deceased")
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "Adopted")
    @status = Status.new
    @status.organization_id = self.id
    @status.update_attributes(:status => "Foster Care")
  end
  
  #create the default animal colors and assign them to the new organization
  def add_default_animal_colors
    @animal_color = AnimalColor.new
    @animal_color.organization_id = self.id
    @animal_color.update_attributes(:color => "Black")
    @animal_color = AnimalColor.new
    @animal_color.organization_id = self.id
    @animal_color.update_attributes(:color => "White")
    @animal_color = AnimalColor.new
    @animal_color.organization_id = self.id
    @animal_color.update_attributes(:color => "Gray")
    @animal_color = AnimalColor.new
    @animal_color.organization_id = self.id
    @animal_color.update_attributes(:color => "Brown")
  end
  
  #create the default species and assign them to the new organization
  def add_default_species
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Cat")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Dog")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Hamster")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Gerbil")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Chinchilla")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Bird")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Rat")
    @species = Species.new
    @species.organization_id = self.id
    @species.update_attributes(:name => "Mouse")
  end
  
  def modify_phone_number
    unless self.phone_number.blank?
      self.phone_number = self.phone_number.delete("^0-9")
    end
  end
  
  def formatted_phone
    unless self.phone_number.blank?
      phone = number_to_phone(self.phone_number)
    else
      phone = ""
    end
    return phone
  end
  
  def has_info?
    return false if self.phone_number.blank? and self.email.blank? and self.website.blank?
    true
  end
  
  def full_address
    "#{address} #{city} #{state} #{zip_code}"
  end
  
  def owner
    User.where(:organization_id => self.id, :owner => 1).first
  end

  def pretty_website
    if self.website && !url_protocol_present?
      "http://#{self.website}"
    else
      self.website
    end
  end

  private

  def url_protocol_present?
    self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
  end
    
    
end
