LocalInfo::Application.routes.draw do
  get "zip_code/index"

  get "zip_code/nearby_zip_codes"

  authenticated :user do
    root :to => 'home#index'
  end

  #root :to => "users#index"
  root :to => "home#index"

  devise_for :users
  resources :users, :only => [:show, :index]
end
