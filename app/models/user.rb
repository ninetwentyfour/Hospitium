class User < ActiveRecord::Base
  has_paper_trail
  has_many :permissions
  has_many :twitter_accounts
  has_many :facebook_accounts
  has_many :wordpress_accounts
  has_many :adopt_a_pet_accounts
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
  
  # show the user email in the admin UI instead of the user id
  def show_username_label_method
    "#{self.username}"
  end
  
  def role?(role)
    #Rails.cache.fetch("role_for_user_#{self.id}_#{self.updated_at}") do
      #self.roles.find_by_name(role.to_s.camelize)
      return !!self.roles.find_by_name(role.to_s.camelize)
      #return !!self.roles.find(:first, :select => 'roles.name, roles.id')
      #Permission.find(:all, :joins => {:roles => :users}, :conditions => ["user.id = ?", self.id])
      #self.roles.joins(:roles).where('roles.id', "%#{var}%")
    #end
  end
  
  def add_default_role
    if self.owner == 1
      @user = self.id
      @permission = Permission.new
      #@permission.update_attributes(:user_id => @user, :role_id => 2)
      @permission.user_id = @user
      @permission.role_id = 2
      @permission.save!
    else
      @user = self.id
      @permission = Permission.new
      #@permission.update_attributes(:user_id => @user, :role_id => 3)
      @permission.user_id = @user
      @permission.role_id = 3
      @permission.save!
    end
  end
  
  def add_to_organization
    if self.organization_id.nil?
      @organization = Organization.new
      @organization.name = self.organization_name
      #@organization.update_attributes(:name => "#{self.organization_name}") 
      @organization.save!
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
