class AdoptAPetAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  attr_accessible :user_name, :password
  
  def self.new_by_user(params, current_user)    
    adopt_a_pet_account = self.new(params)
    adopt_a_pet_account.user_id = current_user.id
    adopt_a_pet_account.active = true
    adopt_a_pet_account.organization_id = current_user.organization_id
    adopt_a_pet_account.password = Base64.encode64("#{adopt_a_pet_account.password}~#{current_user.username}")
    adopt_a_pet_account
  end

end

