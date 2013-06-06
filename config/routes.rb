AnimalTracker::Application.routes.draw do


  #resources :notes
  
  match "/animals/not_available" => "animals#not_available", :via => :get
  
  resource :facebook_accounts, :only => [:new, :destroy]
  match '/callback/facebook/:id' => "facebook_accounts#callback", :as => :facebook_callback
  match "/facebook_accounts/send_wall_post" => "facebook_accounts#send_wall_post", :as => "facebook_accounts"
  match "/facebook_accounts/:id" => "facebook_accounts#destroy", :via => :delete

  
  resource :twitter_accounts, :only => [:new, :destroy]
  match '/callback/twitter/' => "twitter_accounts#callback", :as => :twitter_callback
  match "/twitter_accounts/send_tweet" => "twitter_accounts#send_tweet", :as => "twitter_accounts"
  match "/twitter_accounts/:id" => "twitter_accounts#destroy", :via => :delete
  
  # post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  #force most controllers to /admin
  match "/permissions" => redirect("/admin/permissions"), :via => :get
  match "/permissions/:id" => redirect("/admin/permissions/%{id}"), :via => :get
  match "/permissions/new" => redirect("/admin/permissions/new"), :via => :get
  match "/permissions/:id/edit" => redirect("/admin/permissions/%{id}/edit"), :via => :get
  
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

  resources :spay_neuters

  resources :animal_sexes

  resources :animals, :only => [:show, :index]

  resources :organizations, :only => [:show]
  
  resources :permissions
  
  resources :roles
  
  resources :posts, :only => [:show, :index]
  
  resources :adopt_animals
  
  resources :relinquish_animals
  
  resource :wordpress_accounts, :only => [:create, :update, :destroy]
  match "/wordpress_accounts/send_blog_post" => "wordpress_accounts#send_blog_post", :as => "wordpress_accounts", :via => :post
  match "/wordpress_accounts/:id" => "wordpress_accounts#update", :via => :put
  match "/wordpress_accounts/:id" => "wordpress_accounts#destroy", :via => :delete
  
  # resource :petfinder_accounts
  # match "/petfinder_accounts/send_animal_post" => "petfinder_accounts#send_animal_post", :as => "petfinder_accounts"
  
  resource :adopt_a_pet_accounts, :only => [:create, :update, :destroy]
  match "/send-to-adopt-a-pet" => "adopt_a_pet_accounts#send_animal", :as => "adopt_a_pet_accounts", :via => :get
  match "/adopt_a_pet_accounts/:id" => "adopt_a_pet_accounts#update", :via => :put
  match "/adopt_a_pet_accounts/:id" => "adopt_a_pet_accounts#destroy", :via => :delete
  
  match "/species.:id" => "species#update", :via => :put

    
  devise_for :users#, :controllers => { :sessions => 'users/sessions' } 
  get "home/index"
  root :to => "home#index"
  match "/about" => "home#about", :as => "about", :via => :get
  match "/features" => "home#features", :as => "features", :via => :get
  match "/privacy-and-terms-of-service" => "home#privacy", :as => "privacy", :via => :get
  match "/why-hospitium" => "home#why", :as => "why", :via => :get
  match "/recent-changes" => "home#changes", :as => "changes", :via => :get
  match "/ftp-test" => "adopt_a_pets#send_to_site", :as => "send_to_site"
  
  match "/posts/feed/rss" => "posts#feed", :via => :get
  
  devise_scope :user do
    match '/users/:id', :to => 'users#update', :via => :put
    match '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :users, :only => [:show, :update]
  
  match "/admin/animals/:id/cage_card" => "admin/animals#cage_card", :as => "animals", :via => :get
  match "/admin/animals/:id/qr_code" => "admin/animals#qr_code", :as => "animals", :via => :get
  # Prefix route urls with "admin"
  namespace :admin do
    resources :animals, :species, :statuses, :animal_colors, :shelters, :animal_weights, :adoption_contacts, :organizations, :relinquishment_contacts, :users,
      :vet_contacts, :volunteer_contacts, :notifications, :posts, :notes, :documents, :shots
      
    match "/" => "home#index", :as => "index", :via => :get
    match "animals/:id/duplicate" => "animals#duplicate", :via => :get
    match "statuses.:id" => "statuses#destroy", :via => :delete
  end

  post SecureHeaders::ContentSecurityPolicy::FF_CSP_ENDPOINT => "content_security_policy#scribe"
end
