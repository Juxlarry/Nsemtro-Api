Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do 
    namespace :v1 do
      resources :categories, only: %i[index create show destroy]
      resources :blogs, only: %i[index create show update destroy]
      post 'login', to: 'authentication#create'
      post 'signup', to: 'users#create'
    end 
  end  
end
