class HomeController < ApplicationController  
  skip_before_filter :authenticate_user!, :only => :index
  
  def index 
    # ana sayfa
  end   
  
  def main    
    # üyenin girdiği sayfa
  end
end
