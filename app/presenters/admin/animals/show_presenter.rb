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
    thing = {}
    # AnimalWeight.where(:animal_id => @animal.id).order("date_of_weight ASC").map do |record|
    #   [ record.date_of_weight.strftime("%m/%d/%Y"), record.weight ]
    # end
    @weights = AnimalWeight.where(:animal_id => @animal.id).order("date_of_weight ASC")
    thing[:values] = @weights.map {|record| record.weight }
    thing[:times] = @weights.map {|record| record.date_of_weight.strftime("%m/%d/%Y") }
    thing
  end
  
  def notes
    Note.includes(:user).where(:animal_id => @animal.id)
  end
  
  def documents
    Document.where(:documentable_id => @animal.id, :documentable_type => "Animal")
  end
  
  # def events
  #   Event.where(:animal_id => @animal.id).order('created_at ASC')
  # end
  
end