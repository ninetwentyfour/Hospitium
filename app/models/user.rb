class User < ActiveRecord::Base
  has_paper_trail
  has_many :permissions
  has_many :twitter_accounts
  has_many :facebook_accounts
  has_many :wordpress_accounts
  has_many :roles, :through => :permissions
  #has_and_belongs_to_many :organizations
  belongs_to :organization
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
 # Virtual attribute for authenticating by either username or email
 # This is in addition to a real persisted field like 'username'
 attr_accessor :login
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :organization_name, :owner
  
  before_create :add_to_organization
  after_create :add_default_role
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :organization_name
  validates_uniqueness_of :organization_name, :if => :should_validate_organization_name?
  
  # settings for rails admin views
  rails_admin do
    object_label_method do
      :show_username_label_method # show the user email in the admin UI instead of the user id
    end
    show do
      group :permissions do
        hide
      end
      group :roles do
        hide
      end
      # group :facebook_accounts do
      #   hide
      # end
      # group :twitter_accounts do
      #   hide
      # end
      # group :wordpress_accounts do
      #   hide
      # end
      group :organizations do
        show
      end
      exclude_fields :uuid, :email, :updated_at, :sign_in_count, :remember_created_at, :reset_password_token, :reset_password_sent_at, :current_sign_in_at, :last_sign_in_at,
                            :current_sign_in_ip, :last_sign_in_ip, :id, :password, :password_confirmation, :confirmation_token, :confirmed_at, :confirmation_sent_at, :organization
    end
    create do
      group :permissions do
        hide
      end
      exclude_fields :uuid, :owner
    end
    edit do
      group :permissions do
        hide
      end
      group :roles do
        hide
      end
      group :facebook_accounts do
        hide
      end
      group :twitter_accounts do
        hide
      end
      group :wordpress_accounts do
        hide
      end
      exclude_fields :uuid, :reset_password_sent_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :owner
    end
    list do
      exclude_fields :uuid, :email, :updated_at, :sign_in_count, :remember_created_at, :reset_password_token, :reset_password_sent_at, :current_sign_in_at, :last_sign_in_at,
                            :current_sign_in_ip, :last_sign_in_ip, :id, :confirmation_token, :confirmed_at, :confirmation_sent_at, :organization
    end
  end
  
  # show the user email in the admin UI instead of the user id
  def show_username_label_method
    "#{self.username}"
  end
  
  def role?(role)
    #self.id
    @roles = Rails.cache.fetch("role_for_user_#{self.id}", :expires_in => 5.minutes) do
      self.roles.find_by_name(role.to_s.camelize)
    end
    return !!@roles
      #return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def add_default_role
    if self.owner == 1
      @user = self.id
      @permission = Permission.new
      @permission.update_attributes(:user_id => @user, :role_id => 2)
    else
      @user = self.id
      @permission = Permission.new
      @permission.update_attributes(:user_id => @user, :role_id => 3)
    end
  end
  
  def add_to_organization
    if self.organization_id.nil?
      @organization = Organization.new
      @organization.update_attributes(:name => "#{self.organization_name}") 
      self.organization_id = @organization.id
    else
      #do nothing
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
end
