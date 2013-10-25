WeHungry::Application.routes.draw do
  root to: 'sessions#new'

  # doesnt make sense showing all users on page
  resources :users, except: [:index] do
    member do
      get 'generate_recommendation'
    end

    
    resources :playlist_foods, only: [:show] do
      member do
        put 'like'
      end

      member do
        put 'dislike'
      end
    end
    
  end

  resource :session, only: [:new, :create, :destroy]
end
