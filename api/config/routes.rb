Rails.application.routes.draw do
  
  # Users
  resources :users, only: [:show], param: :login do
    get 'followers', to: 'user_followers#followers'
    get 'followings', to: 'user_followers#followings'
    post 'followers', to: 'user_followers#create'
    delete 'followers', to: 'user_followers#destroy'
    
    get 'statistics', to: 'users#statistics'
    get 'games', to: 'users#games'
    get 'feeds', to: 'users#feeds'
    get 'societies', to: 'users#societies'
    get 'teams', to: 'users#teams'
    delete 'teams/:initials', to: 'users#leave_team'
  end

  resources :societies, except: [:create] do
    get 'ratings', to: 'society_ratings#index'
    post 'ratings', to: 'society_ratings#create'
    put 'ratings', to: 'society_ratings#update'
    patch 'ratings', to: 'society_ratings#update'
    delete 'ratings', to: 'society_ratings#destroy'
    
    get 'tournaments', to: 'societies#get_tournaments'
  end

  resources :teams, param: :initials do
    get 'members', to: 'teams#get_members'
    delete 'members', to: 'teams#delete_members'
    
    get 'roles', to: 'teams#get_roles'
    put 'roles', to: 'teams#update_roles'
    get 'requests', to: 'teams#get_requests'
    post 'requests', to: 'teams#create_requests'
    delete 'requests', to: 'teams#delete_requests'
    
    get 'statistics', to: 'teams#statistics'
  end

  get 'invites', to: 'teams#get_invites'
  put 'invites/:initials', to: 'teams#accept_invite'
  delete 'invites/:initials', to: 'teams#refuse_invite'
  
  resources :games do
    get 'participants', to: 'games#get_participants'
    post 'participants', to: 'games#create_participants'
    delete 'participants', to: 'games#delete_participants'
  end

  get 'feeds', to: 'feeds#index'

  resources :tournaments do
    get 'tickets/:team_initials', to: 'tournament_subscriptions#show'
    post 'tickets/:team_initials', to: 'tournament_subscriptions#create'
    delete 'tickets/:team_initials', to: 'tournament_subscriptions#destroy'
    
    get 'requests', to: 'tournament_subscriptions#index'
    get 'requests/:team_initials', to: 'tournament_subscriptions#show'
    post 'requests/:team_initials', to: 'tournament_subscriptions#accept'
    delete 'requests/:team_initials', to: 'tournament_subscriptions#refuse'
    
    get 'teams', to: 'tournament_teams#index'
    delete 'teams/:team_initials', to: 'tournament_teams#destroy'

    get 'rankings', to: 'tournament_rankings#index'
    post 'rankings', to: 'tournament_rankings#create'
    put 'rankings', to: 'tournament_rankings#update'
    delete 'rankings', to: 'tournament_rankings#destroy'

    resources :matches, param: :order
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
