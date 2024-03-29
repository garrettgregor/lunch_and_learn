Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index]
      resources :learning_resources, only: %i[index]
      resources :air_quality, only: %i[index]
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resources :favorites, only: %i[index create]
    end
  end
end
