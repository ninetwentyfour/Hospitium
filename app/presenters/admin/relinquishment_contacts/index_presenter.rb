class Admin::RelinquishmentContacts::IndexPresenter
  def initialize(user)
    @user = user
  end
  
  def animal
    Animal.organization(@user).order(name: :asc)
  end
end
