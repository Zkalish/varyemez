#encoding:utf-8
class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :create    
                     
  def create
     auth = request.env["omniauth.auth"]              
     authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     if authentication
       flash[:notice] = "Kullanıcı giriş yaptı."
       sign_in_and_redirect(:user, authentication.user)        
     else
        user = User.new
        user.password = Devise.friendly_token[0,20]   
        
        token = ""
        token_secret = ""
        
        if auth['provider'] == "facebook"            
          token = auth['credentials'].token
          user.email = auth['extra']['raw_info'].email                     
        end                                                      
        
        if auth['provider'] == "twitter"
          token = auth['credentials'].token
          token_secret = auth['credentials'].secret
        end         
                                        
        user.authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => token, :token_secret => token_secret)
        
        if user.save
          flash[:notice] = "Kullanıcı giriş yaptı."
          sign_in_and_redirect(:user, user)                
        else
          session[:omniauth] = auth.except('extra')
          redirect_to new_user_registration_path
        end
     end
     
    
  end    
end