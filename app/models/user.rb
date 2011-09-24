class User < ActiveRecord::Base
  has_many :permissions
  has_many :roles, :through => :permissions
  has_and_belongs_to_many :organizations
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
 # Virtual attribute for authenticating by either username or email
 # This is in addition to a real persisted field like 'username'
 attr_accessor :login
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login
  
  
  after_create :add_default_role
  
  validates_presence_of :username
  validates_uniqueness_of :username
  
  # settings for rails admin views
  rails_admin do
    object_label_method do
      :show_username_label_method # show the user email in the admin UI instead of the user id
    end
    show do
      group :permissions do
        hide
      end
      exclude_fields :uuid, :email, :updated_at, :sign_in_count, :remember_created_at, :reset_password_token, :reset_password_sent_at, :current_sign_in_at, :last_sign_in_at,
                            :current_sign_in_ip, :last_sign_in_ip, :id
    end
    create do
      group :permissions do
        hide
      end
      exclude_fields :uuid
    end
    edit do
      group :permissions do
        hide
      end
      group :roles do
        hide
      end
      group :organizations do
        hide
      end
      exclude_fields :uuid, :reset_password_sent_at
    end
    list do
      exclude_fields :uuid, :email, :updated_at, :sign_in_count, :remember_created_at, :reset_password_token, :reset_password_sent_at, :current_sign_in_at, :last_sign_in_at,
                            :current_sign_in_ip, :last_sign_in_ip, :id
    end
  end
  
  # show the user email in the admin UI instead of the user id
  def show_username_label_method
    "#{self.username}"
  end
  
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def add_default_role
    @user = self.id
    @permission = Permission.new
    @permission.update_attributes(:user_id => @user, :role_id => 2) 
  end
  
  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
end
