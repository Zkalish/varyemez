#encoding:utf-8
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
  
  def update
    @credit = @contact.credits.find(params[:id]) 
    @credit.update_attributes(params[:credit])
    if @credit.save 
      Contact.refresh_debt(@contact) 
      redirect_to contact_path(@credit.contact), :notice => "Borç/Alacak kaydı güncellemesi yapıldı."
    else          
      flash[:alert] = "Güncelleme formunda hata ile karşılaşıldı."
      render :edit
    end                                                                                              
    
  end
end