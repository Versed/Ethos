Rails.application.routes.draw do
  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy'
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get "/login" => 'devise/sessions#new', as: :new_user_session
    post "/login" => 'devise/sessions#create', as: :user_session
  end

  root to: 'ideaboards#index'

  resources :ideaboards
  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  scope ":username" do
    resources :albums do
      resources :pictures
    end
  end

  get '/:id', to: 'profiles#show', as: 'profile'

end
