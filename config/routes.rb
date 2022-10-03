Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end

  resources :rooms

  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  get 'user/:id', to: 'users#show', as:'user'  




end
