AnimalTracker::Application.routes.draw do

  resources :statuses

  resources :biters

  resources :spay_neuters

  resources :animal_sexes

  resource :facebook_accounts
  match '/callback/facebook/:id' => "facebook_accounts#callback", :as => :facebook_callback
  match "/facebook_accounts/send_wall_post" => "facebook_accounts#send_wall_post", :as => "facebook_accounts"

  
  resource :twitter_accounts
  match '/callback/twitter/' => "twitter_accounts#callback", :as => :twitter_callback
  match "/twitter_accounts/send_tweet" => "twitter_accounts#send_tweet", :as => "twitter_accounts"
  
  post "versions/:id/revert" => "versions#show", :as => "revert_version"
  
  #force most controllers to /admin
  match "/animals/new" => redirect("/admin/animals/new"), :via => :get
  match "/animals/:id/edit" => redirect("/admin/animals/%{id}/edit"), :via => :get
  
  match "/posts/new" => redirect("/admin/posts/new"), :via => :get
  match "/posts/:id/edit" => redirect("/admin/posts/%{id}/edit"), :via => :get
  
  match "/organizations/new" => redirect("/admin/organizations/new"), :via => :get
  match "/organizations/:id/edit" => redirect("/admin/organizations/%{id}/edit"), :via => :get
  
  match "/animal_colors" => redirect("/admin/animal_colors"), :via => :get
  match "/animal_colors/:id" => redirect("/admin/animal_colors/%{id}"), :via => :get
  match "/animal_colors/new" => redirect("/admin/animal_colors/new"), :via => :get
  match "/animal_colors/:id/edit" => redirect("/admin/animal_colors/%{id}/edit"), :via => :get
  
  match "/animal_weights" => redirect("/admin/animal_weights"), :via => :get
  match "/animal_weights/:id" => redirect("/admin/animal_weights/%{id}"), :via => :get
  match "/animal_weights/new" => redirect("/admin/animal_weights/new"), :via => :get
  match "/animal_weights/:id/edit" => redirect("/admin/animal_weights/%{id}/edit"), :via => :get
  
  match "/vet_contacts" => redirect("/admin/vet_contacts"), :via => :get
  match "/vet_contacts/:id" => redirect("/admin/vet_contacts/%{id}"), :via => :get
  match "/vet_contacts/new" => redirect("/admin/vet_contacts/new"), :via => :get
  match "/vet_contacts/:id/edit" => redirect("/admin/vet_contacts/%{id}/edit"), :via => :get
  
  match "/volunteer_contacts" => redirect("/admin/volunteer_contacts"), :via => :get
  match "/volunteer_contacts/:id" => redirect("/admin/volunteer_contacts/%{id}"), :via => :get
  match "/volunteer_contacts/new" => redirect("/admin/volunteer_contacts/new"), :via => :get
  match "/volunteer_contacts/:id/edit" => redirect("/admin/volunteer_contacts/%{id}/edit"), :via => :get
  
  match "/adoption_contacts" => redirect("/admin/adoption_contacts"), :via => :get
  match "/adoption_contacts/:id" => redirect("/admin/adoption_contacts/%{id}"), :via => :get
  match "/adoption_contacts/new" => redirect("/admin/adoption_contacts/new"), :via => :get
  match "/adoption_contacts/:id/edit" => redirect("/admin/adoption_contacts/%{id}/edit"), :via => :get
  
  match "/relinquishment_contacts" => redirect("/admin/relinquishment_contacts"), :via => :get
  match "/relinquishment_contacts/:id" => redirect("/admin/relinquishment_contacts/%{id}"), :via => :get
  match "/relinquishment_contacts/new" => redirect("/admin/relinquishment_contacts/new"), :via => :get
  match "/relinquishment_contacts/:id/edit" => redirect("/admin/relinquishment_contacts/%{id}/edit"), :via => :get
  
  match "/shelters" => redirect("/admin/shelters"), :via => :get
  match "/shelters/:id" => redirect("/admin/shelters/%{id}"), :via => :get
  match "/shelters/new" => redirect("/admin/shelters/new"), :via => :get
  match "/shelters/:id/edit" => redirect("/admin/shelters/%{id}/edit"), :via => :get
  
  match "/species" => redirect("/admin/species"), :via => :get
  match "/species/:id" => redirect("/admin/species/%{id}"), :via => :get
  match "/species/new" => redirect("/admin/species/new"), :via => :get
  match "/species/:id/edit" => redirect("/admin/species/%{id}/edit"), :via => :get
  
  match "/permissions" => redirect("/admin/permissions"), :via => :get
  match "/permissions/:id" => redirect("/admin/permissions/%{id}"), :via => :get
  match "/permissions/new" => redirect("/admin/permissions/new"), :via => :get
  match "/permissions/:id/edit" => redirect("/admin/permissions/%{id}/edit"), :via => :get
  
  resources :animal_colors

  resources :animal_weights

  resources :vet_contacts

  resources :volunteer_contacts

  resources :adoption_contacts

  resources :relinquishment_contacts

  resources :shelters

  resources :species

  resources :animals

  resources :organizations
  
  resources :permissions
  
  resources :roles
  
  resources :posts
  
  resource :wordpress_accounts
  match "/wordpress_accounts/send_blog_post" => "wordpress_accounts#send_blog_post", :as => "wordpress_accounts"
  
  resource :petfinder_accounts
  match "/petfinder_accounts/send_animal_post" => "petfinder_accounts#send_animal_post", :as => "petfinder_accounts"

    
  devise_for :users
  get "home/index"
  root :to => "home#index"
  match "/about" => "home#about", :as => "about"
  match "/features" => "home#features", :as => "features"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
