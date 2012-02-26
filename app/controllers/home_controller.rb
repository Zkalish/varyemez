class HomeController < ApplicationController   
  skip_before_filter :authenticate_user!, :only => [:index, :intro]
  
  def index                                                            
  end                                                              
 
  def main                                                         
    @twitter = current_user.authentications.find_by_provider("twitter")
    @facebook = current_user.authentications.find_by_provider("facebook") 
  end         
  
end           