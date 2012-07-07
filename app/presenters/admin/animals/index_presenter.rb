class Admin::Animals::IndexPresenter
  def initialize(user)
    @user = user
  end
  
  def status
    Status.organization(@user)
  end
  
  def species
    Species.organization(@user)
  end
  
  def color
    AnimalColor.organization(@user)
  end
  
  def sex
    AnimalSex.all
  end
  
  def spay
    SpayNeuter.all
  end
  
  def biter
    Biter.all
  end
  
  def shelter
    Shelter.organization(@user)
  end
  
  
end