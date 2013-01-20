class Document < ActiveRecord::Base
  before_create :create_uuid
  
  belongs_to :animal
  
  has_attached_file :document, :storage => :s3, :s3_protocol => "https", :s3_credentials => {:access_key_id => ENV['S3_KEY']  || 'thedefaultkey', :secret_access_key => ENV['S3_SECRET']  || 'thedefaultkey'}, :bucket => 'hospitium-static'
  
  attr_accessible :document, :animal_id
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
end
