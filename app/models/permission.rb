# permissions are the join table between users and roles
class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  
  
end
