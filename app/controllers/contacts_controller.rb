#encoding:utf-8
class ContactsController < ApplicationController 
  
  def index             
    @contacts = current_user.contacts    
  end  
  
  def create   
    @contact = Contact.new(params[:contact])
    @contact.user = current_user
    if @contact.save
      flash[:notice] = "Yeni kişi başarılı bir şekilde oluşturuldu."
    else                                                            
      flash[:alert] = "Yeni kişi yaratırken hata ile karşılaşıldı."
    end
  end 
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
  end             
     
end