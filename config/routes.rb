Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'splash#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :groups, only: %i[create index new show]
end
