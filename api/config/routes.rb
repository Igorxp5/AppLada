Rails.application.routes.draw do
  # Users
  resources :users, only: [:show], param: :login do
    get 'followers', to: 'user_followers#followers'
    get 'following', to: 'user_followers#following'
    post 'followers', to: 'user_followers#create'
    delete 'followers', to: 'user_followers#destroy'
  end

  resources :societies

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             },
             defaults: { format: :json }

  # Development routes
   if Rails.env.development?
      get 'main', to: 'main#index'
 	end
end
