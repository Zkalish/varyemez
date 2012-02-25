class HomeController < ApplicationController   
  skip_before_filter :authenticate_user!, :only => [:index, :intro]
  
  def index 
       
  end                                                              
  
  def intro
    render :text => "is under construction  ... "
  end
  
  def main    
    
  end
end
