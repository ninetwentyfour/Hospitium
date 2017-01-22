AnimalTracker::Application.routes.draw do
  mount ActionCable.server => '/cable'
  resource :facebook_accounts, :only => [:new, :destroy]
  get 'callback/facebook/:id', to: 'facebook_accounts#callback', as: :facebook_callback
  post 'facebook_accounts/send_wall_post', to: 'facebook_accounts#send_wall_post'
  delete 'facebook_accounts/:id', to: 'facebook_accounts#destroy'


  resource :twitter_accounts, :only => [:new, :destroy]
  get 'callback/twitter', to: 'twitter_accounts#callback', as: :twitter_callback
  post 'twitter_accounts/send_tweet', to: 'twitter_accounts#send_tweet'
  delete 'twitter_accounts/:id', to: 'twitter_accounts#destroy'

  get '/animals/not_available', to: 'animals#not_available'
  resources :animals, :only => [:show, :index]

  resources :organizations, :only => [:show]

  resources :posts, :only => [:show, :index]

  post 'wordpress_accounts/send_blog_post', to: 'admin/wordpress_accounts#send_blog_post'
  get 'send-to-adopt-a-pet', to: 'admin/adopt_a_pet_accounts#send_animal'

  devise_for :users
  get "home/index"
  root :to => "home#index"
  get 'about', to: 'home#about'
  get 'features', to: 'home#features'
  get 'privacy-and-terms-of-service', to: 'home#privacy'
  get 'why-hospitium', to: 'home#why'
  get 'recent-changes', to: 'home#changes'
  get 'posts/feed/rss', to: 'posts#feed'

  devise_scope :user do
    put 'users/:id', to: 'users#update'
    delete 'users/sign_out', to: 'devise/session#destroy'
  end

  # Prefix route urls with "admin"
  namespace :admin do
    root :to => "home#index"

    resources :species,
              :statuses,
              :animal_colors,
              :shelters,
              :animal_weights,
              :adoption_contacts,
              :organizations,
              :relinquishment_contacts,
              :vet_contacts,
              :volunteer_contacts,
              :notifications,
              :posts,
              :notes,
              :documents,
              :shots,
              :adopt_a_pet_accounts,
              :wordpress_accounts,
              :adopt_animals,
              :relinquish_animals,
              :foster_contacts,
              :foster_animals,
              :contact_notes

    resources :animals do
      resources :animal_weights, :documents, :shots, :notes, :adoption_contacts, :relinquishment_contacts
      member do
        get 'cage_card'
        get 'duplicate'
        get 'qr_code'
        patch 'add_image'
      end
    end

    resources :users do
      member do
        get 'reset_token', to: 'users#reset_token'
        put 'set_role', to: 'users#set_role', as: 'user_role'
        delete 'cancel', to: 'users#cancel', as: 'cancel_user'
      end
    end
  end

  post SecureHeaders::ContentSecurityPolicy::FF_CSP_ENDPOINT => "content_security_policy#scribe"
end
