Rails.application.routes.draw do
  root to: "reading_clubs#index"

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: 'sessions#failure'

  resource :term, only: [:show], controller: 'term'
  resource :privacy, only: [:show], controller: 'privacy'

  resources :reading_clubs, only: [:index] do
    scope module: :reading_clubs do
      resource :overview, only: [:show], controller: 'overview'
      resource :template, only: [:update], controller: 'template'
      resource :read_me, only: [:edit, :update], controller: 'read_me'

      resources :notes, only: [:new, :edit, :create, :update, :destroy], shallow: true
      resources :participants, only: [:create, :destroy], shallow: true
    end

  end
end
