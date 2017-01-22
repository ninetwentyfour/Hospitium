class Admin::FosterContacts::IndexPresenter
  def initialize(user, page, query)
    @user = user
    @query = query
    @page = page
  end

  def foster_contacts
    search.result.paginate(page: @page, per_page: 10).order(updated_at: :desc)
  end

  def search
    FosterContact.organization(@user).search(@query)
  end

  def animal
    Animal.organization(@user).order(name: :asc)
  end
end
