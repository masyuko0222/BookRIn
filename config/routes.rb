Rails.application.routes.draw do
  root to: "reading_clubs#index"

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: redirect('/login')

  resources :reading_clubs, only: [:index] do
    resource :overview, only: [:show], controller: 'reading_clubs/overview'
    resources :participants, only: [:create, :destroy], shallow: true, controller: 'reading_clubs/participants'
    resource :read_me, only: [:show, :edit, :update], controller: 'reading_clubs/read_me'
  end
end
