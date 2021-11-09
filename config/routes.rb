Rails.application.routes.draw do
  devise_for :users
  
  resources :camps do
    post 'start_enrolment', on: :member
  end
  resources :enrolments

  devise_scope :user do
    get 'profile', to: 'users#show'
    get 'user/edit', to: 'users#edit'
    get 'select_camp', to: 'users#select_camp'
    patch 'enroll', to: 'users#enroll'
  end

  namespace :admin do
    resources :users
    resources :camps
    resources :locations
  end

  root to: "home#index"
end
