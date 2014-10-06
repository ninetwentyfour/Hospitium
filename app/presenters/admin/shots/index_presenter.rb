class Admin::Shots::IndexPresenter
  def initialize(user, page, query, animal_id)
    @user = user
    @query = query
    @page = page
    @animal_id = animal_id
  end
  
  def shots
    search.result.paginate(:page => @page, :per_page => 10).order("updated_at DESC")
  end

  def search
    if @animal_id
      Shot.organization(@user).where(animal_id: @animal_id).search(@query)
    else
      Shot.organization(@user).search(@query)
    end
  end

  def animals
    Animal.organization(@user).order("name")
  end
  
end