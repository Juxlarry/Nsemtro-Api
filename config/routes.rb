Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do 
    namespace :v1 do
      resources :categories, only: %i[index create show destroy]
      resources :blogs, only: %i[index create show update destroy]
    end 
  end  
end
