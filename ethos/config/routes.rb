Rails.application.routes.draw do
  devise_for :users
  root to: 'ideaboards#index'

  resources :ideaboards
end
