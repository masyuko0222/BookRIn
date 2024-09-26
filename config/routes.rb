Rails.application.routes.draw do
  root to: "home#index" # tmp path

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#callback'
  get '/auth/failure', to: redirect('/login')
end
