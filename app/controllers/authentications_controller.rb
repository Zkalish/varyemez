class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :create    
  
  def create
     render :text => request.env["omniauth.auth"].to_yaml
  end
  
  
end
