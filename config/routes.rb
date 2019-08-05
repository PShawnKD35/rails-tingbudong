Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :slangs, only: [ :index, :show, :create, :update ] do
        resources :definitions, only: [ :index ]
      end
      resources :definitions, only: [ :create, :update ] do
        post 'likes', to: "definitions#like"
      end
      delete 'likes/:id', to: "definitions#unlike"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
