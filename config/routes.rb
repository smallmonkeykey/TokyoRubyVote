Rails.application.routes.draw do
  root 'home#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  get '/terms', to: 'pages#terms'
  get '/privacy', to: 'pages#privacy'

  resources :events, only: [:show] do
    get 'votes/categories', to: 'votes#categories'
    get 'votes/completions', to: 'votes#completions'
    get 'entries/categories', to: 'entries#categories'
    get 'entries/completions', to: 'entries#completions'

    resources :entries, only: [:new, :create, :index, :show]
    resources :votes, only: [:create]
    resources :rankings, only: [:index]
    resources :comments, only: [:index, :show]
  end

  namespace :admin do
    resources :events, only: [:index, :new, :create, :show, :update]
  end
end
