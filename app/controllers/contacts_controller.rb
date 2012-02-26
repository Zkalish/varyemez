#encoding:utf-8
class ContactsController < ApplicationController 
  
  def index             
    @contacts = current_user.contacts    
  end            
  
  def new
    @contact = Contact.new
  end
  
  def create   
    @contact = Contact.new(params[:contact]) 
    @contact.user = current_user
    if @contact.save
      redirect_to contacts_path, :notice => "Yeni kişi başarılı bir şekilde oluşturuldu."
    else            
      flash[:notice] = "Yeni kişi kaydında hata ile karşılaşıldı."
      render :new
    end
  end   
  
  def edit
    @contact = Contact.find(params[:id])
  end    
  
  def update
    @contact = Contact.find(params[:id])
    @contact.user_id = current_user.id
    if @contact.update_attributes(params[:contact])
      redirect_to contacts_path, :notice => "Kayıt başarılı bir şekilde güncellendi."
    else
      flash[:notice] = "Güncelleme formunda hata ile karşılaşıldı."
      render :edit
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
  
  def lock
    @contact = Contact.find(params[:id])
    @contact.update_attributes(:lock => !@contact.lock)
    redirect_to contacts_path
  end
     
end