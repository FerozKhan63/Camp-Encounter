Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'profile', to: 'users#show'
    get 'user/edit', to: 'users#edit'
  end

  namespace :admin do
    resources :users
  end

  direct :privacy_policy do
    "https://ge-stage-2019.herokuapp.com/privacy_policy"
  end
  
  root to: "home#index"
end
