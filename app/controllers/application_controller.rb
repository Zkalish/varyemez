class ApplicationController < ActionController::Base
  protect_from_forgery    
  before_filter :authenticate_user!                                 
  
  private
  
  def after_sign_in_path_for(resource)
    login_success_path
  end 
  
  def after_sign_out_path_for(resource)
    root_path    
  end
end
