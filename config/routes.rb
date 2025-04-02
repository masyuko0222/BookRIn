Rails.application.routes.draw do
  root to: "reading_clubs#index"

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: redirect('/login')

  resource :term, only: [:show], controller: 'term'
  resource :privacy, only: [:show], controller: 'privacy'

  resources :reading_clubs, only: [:index] do
    resources :participants, only: [:create, :destroy], shallow: true, controller: 'reading_clubs/participants'
    resource :overview, only: [:show], controller: 'reading_clubs/overview'
    resource :read_me, only: [:edit, :update], controller: 'reading_clubs/overview/read_me'
    resource :template, only: [:update], controller: 'reading_clubs/template'
    resources :notes, only: [:new, :edit, :create, :update], shallow: true, controller: 'notes'
  end
end
