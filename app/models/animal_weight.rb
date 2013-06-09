class AnimalWeight < ActiveRecord::Base
  include CommonScopes
  
  belongs_to :animal
  belongs_to :organization
  before_create :create_uuid
  validates_presence_of :weight, :date_of_weight, :animal_id, :organization_id
  
  attr_accessible :animal_id, :weight, :date_of_weight
  
  # show the link in the admin UI instead of the link id
  def show_weight_label_method
    "#{self.weight}"
  end
  
  #create uuid
  def create_uuid()
    self.uuid = UUIDTools::UUID.random_create.to_s
  end
  
  def formatted_weight_date
    unless self.date_of_weight.blank?
      age = self.date_of_weight.strftime("%a, %b %e at %l:%M")
    else
      age = ""
    end
    return age
  end
  
  def as_xls(options = {})
    {
        "Id" => id.to_s,
        "Weight" => weight,
        "Animal" => animal["name"],
        "Date of Weight" => date_of_weight
    }
  end
  
  # ===============
  # = CSV support =
  # ===============
  comma do
    id "ID"
    weight "Weight"
    animal "Animal" do |a| a.name end
    date_of_weight "Date of Weight"
  end
end
