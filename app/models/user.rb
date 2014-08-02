class User < ActiveRecord::Base
  include CommonScopes
  
  has_many :permissions
  has_many :twitter_accounts
  has_many :facebook_accounts
  has_many :wordpress_accounts
  has_many :adopt_a_pet_accounts
  has_many :notes
  has_many :roles, :through => :permissions
  #has_and_belongs_to_many :organizations
  belongs_to :organization
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :confirmable, :lockable
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login, :no_send_email, :skip_default_role
  
  before_create :add_to_organization
  after_create :add_default_role, :send_new_email, :increment_stats

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :organization_name, :owner,
                   :no_send_email, :skip_default_role

  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :organization_name
  validates_uniqueness_of :organization_name, :if => :should_validate_organization_name?
  validate :email_is_not_blacklisted
  
  
  # show the user email in the admin UI instead of the user id
  def show_username_label_method
    "#{self.username}"
  end
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def add_default_role
    unless self.skip_default_role == true
      @user = self.id
      @permission = Permission.new
      @permission.user_id = @user
      if self.owner == 1
        @permission.role_id = 2
      else
        @permission.role_id = 3
      end
      @permission.save!
    end
  end
  
  def add_to_organization
    if self.organization_id.nil?
      @organization = Organization.new
      @organization.name = self.organization_name
      @organization.save!
      self.organization_id = @organization.id
    end
  end
  
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  
  def should_validate_organization_name?
    if self.organization_id.nil?
      true
    else
      false
    end
  end
  
  def send_new_email
    unless Rails.env.test? or self.no_send_email == true
      $statsd.increment 'user.created'
      Thread.new do
        url = "http://sendgrid.com/api/mail.send.json?api_user=#{ENV['SENDGRID_USERNAME']}&api_key=#{ENV['SENDGRID_PASSWORD']}&to=contact@travisberry.com&subject=Hospitium%20-%20New%20User&text=#{URI::encode(self.username)}%20created%20an%20account.%20#{URI::encode(self.email)}%20in%20organization%20#{URI::encode(self.organization.name)}&from=contact@hospitium.co"
        resp = Net::HTTP.get_response(URI.parse(url))
        data = resp.body
        result = JSON.parse(data)
        if result.has_key? 'Error'
           raise "web service error"
        end
      end
    end
  end
  
  def increment_stats
    $statsd.increment 'user.created'
  end

  def email_is_not_blacklisted
    begin
      domain = self.email.split('@').last
      blacklist = Rails.cache.fetch("email_blacklist", :expires_in => 1.day) do
        File.readlines("#{Rails.root}/config/email_blacklist.txt").each {|l| l.chomp!}
      end
      if blacklist.include?(domain)
        errors.add(:email, 'is blacklsited')
      else
        url = "http://check.block-disposable-email.com/api/json/#{ENV['HOSPITIUM_DEA_API']}/#{domain}"
        resp = Net::HTTP.get_response(URI.parse(url))
        result = JSON.parse(resp.body)
        if result['domain_status'] == 'block'
          File.open("#{Rails.root}/config/email_blacklist.txt", 'a') { |f| f.write("\n#{domain}") }
          errors.add(:email, 'is blacklsited')
        end
      end
    rescue
    end
  end
  
end
