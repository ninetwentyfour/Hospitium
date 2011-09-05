class User < ActiveRecord::Base
  has_many :permissions
  has_many :roles, :through => :permissions
  has_and_belongs_to_many :organizations
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # settings for rails admin views
  rails_admin do
    show do
      group :permissions do
        hide
      end
      exclude_fields :uuid
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
      exclude_fields :uuid
    end
    list do
      exclude_fields :uuid
    end
  end
  
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
