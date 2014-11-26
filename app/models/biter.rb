class Biter < ActiveRecord::Base
  default_scope lambda {order(created_at: :asc)}
  has_many :animals

  attr_accessible :value
  
  # show the link in the admin UI instead of the link id
  def show_value_label_method
    self.value.to_s
  end
end
