class Admin::AdoptionContacts::IndexPresenter
  def initialize(user, page, query, animal_id)
    @user = user
    @query = query
    @page = page
    @animal_id = animal_id
  end
  
  def adoption_contacts
    search.result.paginate(page: @page, per_page: 10).order(updated_at: :desc)
  end

  def search
    if @animal_id
      AdoptionContact.joins(:adopt_animals).organization(@user).where(adopt_animals: {animal_id: @animal_id}).search(@query)
    else
      AdoptionContact.organization(@user).search(@query)
    end
  end

  def animal
    Animal.organization(@user).order(name: :asc)
  end  
end
