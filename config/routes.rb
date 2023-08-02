Rails.application.routes.draw do
  root 'top#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  resources :quotes do
    resources :comments, only: %i[create destroy]
  end
  resources :children, only: %i[new create]

  get 'terms', to: 'top#terms'
  get 'privacy', to: 'top#privacy'
end
