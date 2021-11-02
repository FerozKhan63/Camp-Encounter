Rails.application.routes.draw do
  devise_for :users
  
  # scope '/admin' do
  #   resources :users
  # end

  resource :user

  namespace :admin do
    resources :users
  end

  
  root to: "home#index"
end
