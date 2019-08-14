Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      # Login
      post '/login', to: 'login#login'

      # Users, Slangs, Definitions
      resources :users, only: [ :update, :show ]
      resources :slangs, only: [ :index, :show, :create, :update, :destroy ]
      resources :definitions, only: [ :create, :update, :destroy ]

      # Likes
      post 'likes', to: "definitions#like"
      delete 'likes/:id', to: "definitions#unlike"

      # Tags
      get '/tags', to: "slangs#tags"
      post '/tags', to: "slangs#add_tag"
      delete '/tags', to: "slangs#remove_tag"

      # Favorites
      resources :favorites, only: [ :index, :create ]
      delete '/favorites', to: "favorites#destroy"
      
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
