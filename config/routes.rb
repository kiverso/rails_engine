Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'highest_revenue#index'
        get '/most_items', to: 'most_items#index'
      end
    end
  end
  namespace :api do
    namespace :v1 do

      resources :items, only: [:index, :show, :create, :destroy, :update] do
        resource :merchant, only: [:show], controller: 'merchants'
      end

      resources :merchants, only: [:index, :show, :create, :destroy, :update] do
        resources :items, only: [:index]
      end

      get '/revenue', to: 'revenue#index'
      get '/merchants/:id/revenue', to: 'revenue#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
