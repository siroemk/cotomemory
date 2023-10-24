Rails.application.routes.draw do
  root 'top#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  resources :quotes do
    resources :comments, only: %i[new create destroy]
  end
  resources :children, only: %i[index new edit create update destroy]
  resource :family, only: %i[show]
  resource :user, only: %i[update destroy]
  get 'user', to: 'users#edit'
  get 'terms', to: 'top#terms'
  get 'privacy', to: 'top#privacy'
  get 'welcome', to: 'top#welcome'
end
