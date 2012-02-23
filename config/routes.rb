Varyemez::Application.routes.draw do
 
  root :to => "home#index"
  
  get "home/main", :as => "login_success"

  devise_for :users, :path => "uyeler"

end