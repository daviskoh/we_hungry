WeHungry::Application.routes.draw do
  # doesnt make sense showing all users on page
  resources :users, except: [:index] do
    member do
      get 'generate_recommendation'
    end

    member do
      put 'like'
    end

    member do
      put 'dislike'
    end
  end

  resources :playlist_foods, only: [:show]

  resource :session, only: [:new, :create, :destroy]
end
