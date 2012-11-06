LocalInfo::Application.routes.draw do
  #controller :zip_code do
  #  match 'zip_code/index'                => :index
  #  match 'zip_code/nearby_zip_codes'     => :nearby_zip_codes
  #end

  #controller :home do
  #  match 'home/add_neighbor'     => :add_neighbor
  #end

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "users#index"

  devise_for :users

  resources :users, :only => [:show, :index]

  match ':controller(/:action(/:id))(.:format)'
end
