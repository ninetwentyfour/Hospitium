class AnimalSex < ActiveRecord::Base
  default_scope -> { order(created_at: :asc) }
  has_many :animals

  attr_accessible :sex

  # show the link in the admin UI instead of the link id
  def show_sex_label_method
    sex
  end
end
