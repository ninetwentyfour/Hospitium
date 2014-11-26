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

  ORGANIZATION_FORM_OPTIONS = {
    storage: :s3,
    s3_protocol: 'https',
    s3_credentials: {access_key_id: ENV['S3_KEY'], secret_access_key: ENV['S3_SECRET']},
    bucket: 'hospitium-static-v2',
    url: '/system/:attachment/:hash/:filename',
    hash_secret: ENV['SALTY']
  }

  has_attached_file :adoption_form, 
                    ORGANIZATION_FORM_OPTIONS.merge(default_url: 'https://d4uktpxr9m70.cloudfront.net/pdfs/Adoption-Form.pdf')
  has_attached_file :volunteer_form,
                    ORGANIZATION_FORM_OPTIONS.merge(default_url: 'https://d4uktpxr9m70.cloudfront.net/pdfs/Volunteer-Application.pdf')
  has_attached_file :relinquishment_form,
                    ORGANIZATION_FORM_OPTIONS
  has_attached_file :foster_form,
                    ORGANIZATION_FORM_OPTIONS
  validates_attachment_content_type :adoption_form, content_type: [ 'application/pdf',
                                                                    'application/msword',
                                                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                                                    'application/vnd.openxmlformats-officedocument.wordprocessingml.template']
  
  has_many :adoption_contacts, dependent: :destroy
  has_many :animals, dependent: :destroy
  has_many :animal_colors, dependent: :destroy
  has_many :animal_weights, dependent: :destroy
  has_many :documents
  has_many :facebook_accounts, dependent: :destroy
  has_many :relinquishment_contacts, dependent: :destroy
  has_many :shelters, dependent: :destroy
  has_many :shots, dependent: :destroy
  has_many :species, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :twitter_accounts, dependent: :destroy
  has_many :vet_contacts, dependent: :destroy
  has_many :volunteer_contacts, dependent: :destroy
  has_many :wordpress_accounts, dependent: :destroy
  has_many :foster_contacts, dependent: :destroy
  has_many :users, dependent: :destroy
  
  before_update :modify_phone_number
  after_create :add_default_status, :add_default_animal_colors, :add_default_species

  attr_accessible :name, :phone_number, :address, :city, :state, :zip_code, :email, :website, :adoption_form, :volunteer_form, :relinquishment_form, :foster_form

  validates_uniqueness_of :name
  
  #create the default statuses and assign them to the new organization
  def add_default_status
    ['Adoptable', 'New Intake', 'Sanctuary', 'Sick', 'Deceased', 'Adopted', 'Foster Care'].each do |status_name|
      status = Status.new(status: status_name)
      status.organization_id = self.id
      status.save
    end
  end
  
  #create the default animal colors and assign them to the new organization
  def add_default_animal_colors
    ['Black', 'White', 'Gray', 'Brown'].each do |color_name|
      animal_color = AnimalColor.new(color: color_name)
      animal_color.organization_id = self.id
      animal_color.save
    end
  end
  
  #create the default species and assign them to the new organization
  def add_default_species
    ['Cat', 'Dog', 'Hamster', 'Gerbil', 'Chinchilla', 'Bird', 'Rat', 'Mouse'].each do |species_name|
      species = Species.new(name: species_name)
      species.organization_id = self.id
      species.save
    end
  end
  
  def modify_phone_number
    # unless self.phone_number.blank?
      self.phone_number = self.phone_number.delete("^0-9") unless self.phone_number.blank?
    # end
  end
  
  def formatted_phone
    self.phone_number.blank? ? '' : number_to_phone(self.phone_number)
  end
  
  def has_info?
    return false if self.phone_number.blank? and self.email.blank? and self.website.blank?
    true
  end
  
  def full_address
    "#{address} #{city} #{state} #{zip_code}"
  end
  
  def owner
    User.where(organization_id: self.id, owner: 1).first
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
