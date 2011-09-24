# Role model
class Role < ActiveRecord::Base
  has_paper_trail # use versioning
  has_many :permissions
  has_many :users, :through => :permissions # use join table permissions
  
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
end