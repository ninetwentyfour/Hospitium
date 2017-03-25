class User < ActiveRecord::Base
  include CommonScopes

  has_many :permissions
  has_many :twitter_accounts
  has_many :facebook_accounts
  has_many :wordpress_accounts
  has_many :adopt_a_pet_accounts
  has_many :notes
  has_many :contact_notes
  has_many :roles, through: :permissions
  belongs_to :organization
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :confirmable, :lockable
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login, :no_send_email, :skip_default_role, :unconfirmed_email

  before_create :add_to_organization
  after_create :add_default_role, :increment_stats
  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :organization_name, :owner,
                  :no_send_email, :skip_default_role

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :organization_name, presence: true
  validates :organization_name, uniqueness: { if: :should_validate_organization_name? }
  validate :email_is_not_blacklisted

  # show the user email in the admin UI instead of the user id
  def show_username_label_method
    username
  end

  def role?(role)
    !!roles.find_by(name: role.to_s.camelize)
  end

  def add_default_role
    return if skip_default_role == true
    role_id = owner == 1 ? 2 : 3
    permission = Permission.new(user_id: id, role_id: role_id)
    permission.save!
  end

  def add_to_organization
    if organization_id.nil?
      organization = Organization.new(name: organization_name)
      organization.save!
      self.organization_id = organization.id
    end
  end

  def generate_authentication_token
    # create a longer token and check that it isn't set on some other user
    loop do
      token = Devise.friendly_token + Devise.friendly_token + Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  protected

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
  end

  def should_validate_organization_name?
    organization_id.nil?
  end

  def increment_stats
    $statsd.increment 'user.created'
  end

  def email_is_not_blacklisted
    unless Rails.env.test?
      begin
        domain = email.split('@').last
        blacklist = Rails.cache.fetch('email_blacklist', expires_in: 1.day) do
          EmailBlacklist.all.map(&:domain)
        end
        if blacklist.include?(domain)
          errors.add(:email, 'is blacklisted')
        else
          url = "http://check.block-disposable-email.com/api/json/#{ENV['HOSPITIUM_DEA_API']}/#{domain}"
          resp = Net::HTTP.get_response(URI.parse(url))
          result = JSON.parse(resp.body)
          if result['domain_status'] == 'block'
            new_block = EmailBlacklist.new
            new_block.domain = domain
            new_block.save!
            Rails.cache.delete('email_blacklist')
            errors.add(:email, 'is blacklisted')
          end
        end
      rescue
      end
    end
  end
end
