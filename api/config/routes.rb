Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'signup', to: 'signup#create'
  post 'login', to: 'login#auth'

  # Development routes
   if Rails.env.development?
      get 'main', to: 'main#index'
 	end
end
