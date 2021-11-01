Rails.application.routes.draw do
  devise_for :users
  
  # scope '/admin' do
  #   resources :users
  # end

  namespace :admin do
    resources :users
  end
  resources :users

  
  root to: "home#index"
end
