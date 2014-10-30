Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
  end

  root to: 'ideaboards#index'

  resources :ideaboards
  resources :user_friendships
  get '/:id', to: 'profiles#show', as: 'profile'
end
