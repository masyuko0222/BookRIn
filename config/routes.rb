Rails.application.routes.draw do
  root to: "reading_clubs#index"

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: redirect('/login')

  resources :reading_clubs, only: [:index] do
    get 'overview', on: :member
    resources :participants, only: [:create, :destroy], shallow: true, controller: 'reading_clubs/participants'
    resource :template, only: [:update], controller: 'reading_clubs/template'
    resource :read_me, only: [:edit, :update], controller: 'reading_clubs/overview/read_me'
    resources :notes, only: [:new, :edit, :create, :update, :destroy], shallow: true, controller: 'notes'
  end
end
