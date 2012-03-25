class AdoptAPetAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  attr_accessible :user_name, :password
    
  
  # show the user email in the admin UI instead of the user id
  def show_wordpress_label_method
    "#{self.user_name}"
  end
  

end

