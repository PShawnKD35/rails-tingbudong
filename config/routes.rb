Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/login', to: 'login#login'
      resources :users, only: [ :update, :show ]
      resources :slangs, only: [ :index, :show, :create, :update ]
      resources :definitions, only: [ :create, :update ]
      post 'likes', to: "definitions#like"
      delete 'likes/:id', to: "definitions#unlike"
      get '/tags', to: "slangs#tags"
      post '/tags', to: "slangs#add_tag"
      delete '/tags', to: "slangs#remove_tag"
      resources :favorites, only: [ :index, :create ]
      delete '/favorites', to: "favorites#destroy"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
