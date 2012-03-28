class AdoptAPetAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  attr_accessible :user_name, :password

end

