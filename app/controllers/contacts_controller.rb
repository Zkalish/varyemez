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
  
  def alacaklar
    @contacts = current_user.contacts.borclular.select("id, first_name, last_name, debt, phone, email")
    respond_to do |format|
      format.html
      format.xls { send_data @contacts.to_xls }
    end
  end                                                                             
  def borclar
    @contacts = current_user.contacts.alacaklilar.select("id, first_name, last_name, debt, phone, email")
    respond_to do |format|
      format.html
      format.xls { send_data @contacts.to_xls }
    end
  end
     
end