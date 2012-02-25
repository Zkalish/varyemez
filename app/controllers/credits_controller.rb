class CreditsController < ApplicationController
  before_filter :get_contact
  
  def get_contact
    @contact = Contact.find(params[:contact_id])
  end
  
  def create
    @credit = @contact.credits.build(params[:credit])
    @credit.save    
  end           
  
  def edit
    @credit = @contact.credits.find(params[:id])    
  end
end