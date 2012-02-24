Varyemez::Application.routes.draw do

  root :to => "home#index"
  
  get "home/main", :as => "login_success"

  devise_for :users, :path => "uyeler", :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

end