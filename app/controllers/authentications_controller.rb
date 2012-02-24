#encoding:utf-8
class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :create    
                     
  def create
     auth = request.env["omniauth.auth"]              
     authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     if authentication 
     else
        User.transaction do 
          user = User.new
          user.password = Devise.friendly_token[0,20]
          user.email = "guzelmurat@gmail.com"
          user.authentications.build(:provider => auth['provider'], :uid => auth['uid'])
          user.save!       
        end         
        flash[:notice] = "Kullanıcı giriş yaptı."
        sign_in_and_redirect(:user, user)
     end
     
    
  end    
end