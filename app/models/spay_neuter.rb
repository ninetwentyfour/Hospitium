class SpayNeuter < ActiveRecord::Base
  default_scope -> { order(created_at: :asc) }
  has_many :animals

  attr_accessible :spay

  # show the link in the admin UI instead of the link id
  def show_spay_label_method
    spay
  end
end
