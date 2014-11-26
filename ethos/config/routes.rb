Rails.application.routes.draw do
  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    delete '/logout', to: 'devise/sessions#destroy'
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get "/login" => 'devise/sessions#new', as: :new_user_session
    post "/login" => 'devise/sessions#create', as: :user_session
  end

  root to: 'ideaboards#index'

  resources :ideaboards do
    member do
      get 'about'
      get 'discussion'
      get 'activity'
    end
  end

  resources :tags, only: [:index, :show, :create, :destroy], param: 'tag_id'
  resources :skills, only: [:index, :show, :create, :destroy], param: 'skill_id'
  resources :activities, only: [:index]
  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end

  scope ":ideaboard/:id" do
    resources :albums do
      resources :pictures, param: 'picture_id'
    end

    resources :likes, :only => [:index, :create, :destroy]
    resources :collaborations, param: 'collaboration_id' do
      member do
        put :accept
        put :block
      end
    end
  end

  get '/users', to: 'user_friendships#list', as: 'users_list'
  get '/:id', to: 'profiles#show', as: 'profile'
  get '/:id/friends', to: 'profiles#friends', as: 'friends_list'
  get '/:id/ideaboards', to: 'ideaboards#list', as: 'ideaboards_list'
end
