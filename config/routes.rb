AnimalTracker::Application.routes.draw do


  resources :notes

  resource :facebook_accounts
  match '/callback/facebook/:id' => "facebook_accounts#callback", :as => :facebook_callback
  match "/facebook_accounts/send_wall_post" => "facebook_accounts#send_wall_post", :as => "facebook_accounts"
  match "/facebook_accounts/:id" => "facebook_accounts#destroy", :via => :delete

  
  resource :twitter_accounts
  match '/callback/twitter/' => "twitter_accounts#callback", :as => :twitter_callback
  match "/twitter_accounts/send_tweet" => "twitter_accounts#send_tweet", :as => "twitter_accounts"
  match "/twitter_accounts/:id" => "twitter_accounts#destroy", :via => :delete
  
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
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
  
  match "/notifications" => redirect("/admin/notifications"), :via => :get
  match "/notifications/:id" => redirect("/admin/notifications/%{id}"), :via => :get
  match "/notifications/new" => redirect("/admin/notifications/new"), :via => :get
  match "/notifications/:id/edit" => redirect("/admin/notifications/%{id}/edit"), :via => :get
  
  match "/statuses" => redirect("/admin/statuses"), :via => :get
  match "/statuses/:id" => redirect("/admin/statuses/%{id}"), :via => :get
  match "/statuses/new" => redirect("/admin/statuses/new"), :via => :get
  match "/statuses/:id/edit" => redirect("/admin/statuses/%{id}/edit"), :via => :get
  
  match "/biters" => redirect("/admin/biters"), :via => :get
  match "/biters/:id" => redirect("/admin/biters/%{id}"), :via => :get
  match "/biters/new" => redirect("/admin/biters/new"), :via => :get
  match "/biters/:id/edit" => redirect("/admin/biters/%{id}/edit"), :via => :get
  
  match "/animal_sexes" => redirect("/admin/animal_sexes"), :via => :get
  match "/animal_sexes/:id" => redirect("/admin/animal_sexes/%{id}"), :via => :get
  match "/animal_sexes/new" => redirect("/admin/animal_sexes/new"), :via => :get
  match "/animal_sexes/:id/edit" => redirect("/admin/animal_sexes/%{id}/edit"), :via => :get
  
  match "/spay_neuters" => redirect("/admin/spay_neuters"), :via => :get
  match "/spay_neuters/:id" => redirect("/admin/spay_neuters/%{id}"), :via => :get
  match "/spay_neuters/new" => redirect("/admin/spay_neuters/new"), :via => :get
  match "/spay_neuters/:id/edit" => redirect("/admin/spay_neuters/%{id}/edit"), :via => :get
  
  resources :biters
  
  resources :notifications

  resources :statuses

  resources :spay_neuters

  resources :animal_sexes
  
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
  
  resources :adopt_animals
  
  resources :relinquish_animals
  
  #resources :users
  
  resource :wordpress_accounts
  match "/wordpress_accounts/send_blog_post" => "wordpress_accounts#send_blog_post", :as => "wordpress_accounts"
  match "/wordpress_accounts/:id" => "wordpress_accounts#update", :via => :put
  match "/wordpress_accounts/:id" => "wordpress_accounts#destroy", :via => :delete
  
  resource :petfinder_accounts
  match "/petfinder_accounts/send_animal_post" => "petfinder_accounts#send_animal_post", :as => "petfinder_accounts"
  
  resource :adopt_a_pet_accounts
  match "/send-to-adopt-a-pet" => "adopt_a_pet_accounts#send_animal", :as => "adopt_a_pet_accounts"
  match "/adopt_a_pet_accounts/:id" => "adopt_a_pet_accounts#update", :via => :put
  match "/adopt_a_pet_accounts/:id" => "adopt_a_pet_accounts#destroy", :via => :delete
  
  match "/species.:id" => "species#update", :via => :put
  match "/admin/statuses.:id" => "admin/statuses#destroy", :via => :delete

    
  devise_for :users#, :controllers => { :sessions => 'users/sessions' } 
  get "home/index"
  root :to => "home#index"
  match "/about" => "home#about", :as => "about"
  match "/features" => "home#features", :as => "features"
  match "/privacy-and-terms-of-service" => "home#privacy", :as => "privacy"
  match "/ftp-test" => "adopt_a_pets#send_to_site", :as => "send_to_site"
  match "/admin" => "admin/home#index", :as => "index"
  match "/admin/animals/:id/duplicate" => "admin/animals#duplicate", :via => :get
  
  devise_scope :user do
    match '/users/:id', :to => 'users#update', :via => :put
    match '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :users, :only => [:show, :update]
  
  
  
  # Prefix route urls with "admin" and route names with "rails_admin_"
  namespace :admin do
    resources :animals, :species, :statuses, :animal_colors, :shelters, :animal_weights, :adoption_contacts, :organizations, :relinquishment_contacts, :users,
      :vet_contacts, :volunteer_contacts, :notifications, :posts
  end
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
