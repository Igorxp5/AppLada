Rails.application.routes.draw do
  
  # Users
  resources :users, only: [:show], param: :login do
    get 'followers', to: 'user_followers#followers'
    get 'following', to: 'user_followers#following'
    post 'followers', to: 'user_followers#create'
    delete 'followers', to: 'user_followers#destroy'
  end

  resources :societies

  

  resources :teams, param: :initials do
    get 'members', to: 'teams#get_members'
    delete 'members', to: 'teams#delete_members'
    get 'roles', to: 'teams#get_roles'
    put 'roles', to: 'teams#update_roles'
    get 'requests', to: 'teams#get_requests'
    post 'requests', to: 'teams#create_requests'
    delete 'requests', to: 'teams#delete_requests'
  end

  get 'invites', to: 'teams#get_invites'
  put 'invites/:initials', to: 'teams#accept_invite'
  delete 'invites/:initials', to: 'teams#refuse_invite'
  
  
  
  resources :games do
    get 'participants', to: 'games#get_participants'
    post 'participants', to: 'games#create_participants'
    delete 'participants', to: 'games#delete_participants'
  end

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
