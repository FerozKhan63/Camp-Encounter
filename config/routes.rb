Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'profile', to: 'users#show'
    get 'user/edit', to: 'users#edit'
  end

  namespace :admin do
    resources :users
    resources :camps do
      member do
        get :toggle_status
      end
    end
    resources :locations
  end
  
  root to: "home#index"
end
