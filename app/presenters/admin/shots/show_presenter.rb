class Admin::Shots::ShowPresenter
  def initialize(id, user)
    @id = id
    @user = user
  end

  def shot
    Shot.find(@id)
  end

  def animals
    Animal.where(organization_id: @user.organization_id).collect { |x| [x.id.to_s, x.name.to_s] }
  end
end
