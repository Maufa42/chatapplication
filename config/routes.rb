Rails.application.routes.draw do
<<<<<<< HEAD
<<<<<<< HEAD
  get 'users/show'
  resources :rooms do
    resources :messages
  end
=======
  resources :rooms
>>>>>>> main
=======
  resources :rooms
>>>>>>> parent of 0474c70... ➕  Added Stimulas Controller
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
<<<<<<< HEAD
<<<<<<< HEAD
  get 'user/:id', to: 'users#show', as:'user'  


  
=======
  get "user/:id", to:"users#show", as: "user"
>>>>>>> main
=======
  
  devise_for :users
>>>>>>> parent of 0474c70... ➕  Added Stimulas Controller



end
