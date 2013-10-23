WeHungry::Application.routes.draw do
  # doesnt make sense showing all users on page
  resources :users, except: [:index]

  resource :session, only: [:new, :create, :destroy]
end
