class AdoptAPetAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  # settings for rails admin views
  # rails_admin do
  #   object_label_method do
  #     :show_wordpress_label_method # show the user email in the admin UI instead of the user id
  #   end
  # end
  
  
  # show the user email in the admin UI instead of the user id
  def show_wordpress_label_method
    "#{self.user_name}"
  end
  

end

