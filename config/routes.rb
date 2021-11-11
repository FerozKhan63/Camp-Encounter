Rails.application.routes.draw do
  devise_for :users
  
  resources :enrolments

  resources :camps do
    post 'start_enrolment', on: :member
  end
  
  devise_scope :user do
    get 'profile', to: 'users#show'
    get 'user/edit', to: 'users#edit'
    get 'select_camp', to: 'users#select_camp'
    patch 'enroll', to: 'users#enroll'
  end

  namespace :admin do
    resources :users
    resources :camps do
      member do
        get :toggle_status
      end
    end
    resources :locations
    resources :enrolments
  end

  namespace :api do
    namespace :v1 do
      resources :enrolments, only: [:index, :show, :create, :update, :destroy]
    end
  end

  root to: "home#index"
end
