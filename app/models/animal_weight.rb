class AnimalWeight < ActiveRecord::Base
  include CommonScopes

  belongs_to :animal
  belongs_to :organization

  attr_accessible :animal_id, :weight, :date_of_weight

  validates :weight, :date_of_weight, :animal_id, :organization_id, presence: true

  # show the link in the admin UI instead of the link id
  def show_weight_label_method
    weight.to_s
  end

  def formatted_weight_date
    if date_of_weight.blank?
      age = ''
    else
      age = date_of_weight.strftime('%a, %b %e at %l:%M')
    end
    age
  end

  def as_xls(_options = {})
    {
      'Id' => id.to_s,
      'Weight' => weight,
      'Animal' => animal['name'],
      'Date of Weight' => date_of_weight
    }
  end

  # ===============
  # = CSV support =
  # ===============
  comma do
    id 'ID'
    weight 'Weight'
    animal 'Animal', &:name
    date_of_weight 'Date of Weight'
  end
end
