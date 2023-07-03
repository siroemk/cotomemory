Rails.application.routes.draw do
  root 'top#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  resources :quotes, only: %i[index]
end
