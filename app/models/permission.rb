# permissions are the join table between users and roles
class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  
  # settings for rails admin views
  rails_admin do
    visible false # dont show permissions to users in rails admin UI
  end
  
end
