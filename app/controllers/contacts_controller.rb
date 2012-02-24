class ContactsController < ApplicationController 

  
  def index             
    @contacts = current_user.contacts    
  end                
  
  def new
    @contact = current_user.contacts.build    
  end    
  
  
end
