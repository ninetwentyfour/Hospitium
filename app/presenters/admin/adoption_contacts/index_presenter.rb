class Admin::AdoptionContacts::IndexPresenter
  def initialize(user, page, query)
    @user = user
    @query = query
    @page = page
  end
  
  def adoption_contacts
    search.result.paginate(:page => @page, :per_page => 10).order("updated_at DESC")
  end

  def search
    AdoptionContact.organization(@user).search(@query)
  end

  def animal
    Animal.organization(@user).order("name ASC")
  end  
  
end