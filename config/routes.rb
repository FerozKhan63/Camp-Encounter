Rails.application.routes.draw do
  devise_for :users

  resources :camps, only: [:show, :index] do
    post 'start_enrolment', on: :member
  end
  resources :enrolments, only: [:show, :update]

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
    resources :locations, except: [:show]
    resources :enrolments, except: [:new, :create]
  end

  namespace :api do
    namespace :v1 do
      resources :enrolments, only: [:index, :show, :create, :update, :destroy]
    end
  end

  direct :privacy_policy do
    "https://ge-stage-2019.herokuapp.com/privacy_policy"
  end

  root to: "home#index"
end
