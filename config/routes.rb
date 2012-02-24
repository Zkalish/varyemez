Varyemez::Application.routes.draw do

  root :to => "home#index"
  
  match '/kontrol-panelim.html' => "home#main", :as => "login_success"
  match '/auth/:provider/callback' => 'authentications#create' 

  devise_for :users, :path => "uyeler", :controllers => { :registrations => 'registrations' }
  resources :authentications                                   
  resources :contacts, :path => "kisiler"
  


end