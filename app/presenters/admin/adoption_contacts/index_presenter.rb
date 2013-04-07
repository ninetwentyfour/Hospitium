class Admin::AdoptionContacts::IndexPresenter
  def initialize(user)
    @user = user
  end
  
  def animal
    Animal.organization(@user).order("name ASC")
  end  
  
end