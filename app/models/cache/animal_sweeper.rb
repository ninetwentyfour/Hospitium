class AnimalSweeper < ActionController::Caching::Sweeper
  observe Animal # This sweeper is going to keep an eye on the Product model
 
  # If our sweeper detects that a Product was created call this
  def after_create(animal)
    expire_cache_for(animal)
  end
 
  # If our sweeper detects that a Product was updated call this
  def after_update(animal)
    expire_cache_for(animal)
  end
 
  # If our sweeper detects that a Product was deleted call this
  def after_destroy(animal)
    expire_cache_for(animal)
  end
 
  private
  def expire_cache_for(animal)
    # Expire the index page now that we added a new product
    #expire_page(:controller => 'animals', :action => 'show')
 
    # Expire a fragment
    expire_fragment('all_available_animals')
    expire_fragment('animal')
  end
end