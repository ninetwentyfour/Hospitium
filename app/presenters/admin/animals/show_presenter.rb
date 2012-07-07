class Admin::Animals::ShowPresenter
  def initialize(user, animal)
    @user = user
    @animal = animal
  end
  
  def statuses
    Status.organization(@user).collect{|x| [x.id.to_s,x.status.to_s]}
  end
  
  def species
    Species.organization(@user).collect{|x| [x.id.to_s,x.name.to_s]}
  end
  
  def colors
    AnimalColor.organization(@user).collect{|x| [x.id.to_s,x.color.to_s]}
  end
  
  def shelters
    Shelter.organization(@user).collect{|x| [x.id.to_s,x.name.to_s]}
  end
  
  def animal_weights
    AnimalWeight.where(:animal_id => @animal.id).order("date_of_weight ASC").map do |record|
      [ record.date_of_weight.strftime("%m/%d/%Y"), record.weight ]
    end
  end
  
  def notes
    Note.includes(:user).where(:animal_id => @animal.id)
  end
  
end