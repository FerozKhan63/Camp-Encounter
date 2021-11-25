Rails.application.routes.draw do
  devise_for :users
  
  resources :camps do
    post 'start_enrolment', on: :member
  end
  resources :enrolments

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

  direct :privacy_policy do
    "https://ge-stage-2019.herokuapp.com/privacy_policy"
  end
  
  root to: "home#index"
end
