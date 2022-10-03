Rails.application.routes.draw do
<<<<<<< HEAD
  get 'users/show'
  resources :rooms do
    resources :messages
  end
=======
  resources :rooms
>>>>>>> main
  root 'pages#home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
<<<<<<< HEAD
  get 'user/:id', to: 'users#show', as:'user'  


  
=======
  get "user/:id", to:"users#show", as: "user"
>>>>>>> main



end
