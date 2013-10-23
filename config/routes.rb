WeHungry::Application.routes.draw do
  # doesnt make sense showing all users on page
  resources :users, except: [:index] do
    member do
      get 'generate_recommendation'
    end
  end

  resource :session, only: [:new, :create, :destroy]
end
