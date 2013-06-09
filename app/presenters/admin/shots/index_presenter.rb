class Admin::Shots::IndexPresenter
  def initialize(user, page, query)
    @user = user
    @query = query
    @page = page
  end
  
  def shots
    search.result.paginate(:page => @page, :per_page => 10).order("updated_at DESC")
  end

  def search
    Shot.organization(@user).search(@query)
  end

  def animals
    Animal.organization(@user).order("name")
  end
  
end