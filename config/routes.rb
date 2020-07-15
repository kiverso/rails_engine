Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#index'
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
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
