#encoding:utf-8
class CreditsController < ApplicationController
  before_filter :get_contact
  
  def get_contact
    @contact = Contact.find(params[:contact_id])
  end    
  
  def new
    @credit = @contact.credits.build
  end
  
  def create
    @credit = @contact.credits.build(params[:credit]) 
    
    # limit değerleri kontrol edilecek ve uyarı varsa verilecek.
    if !params[:accept]
      unless @credit.borc_verilebilirmi
        flash[:notice] = "Borç vermenizi şiddetle tavsiye etmiyorum."
        render :new; return
      end              
    end
    
    if @credit.save 
      redirect_to contact_path(@contact), :notice => "Kayıt başarılı bir şekilde gerçekleştirildi."
    else        
      flash[:notice] = "Kayıt girişinde hata ile karşılaşıldı"
      render :new
    end   
  end           
  
  def edit
    @credit = @contact.credits.find(params[:id])    
  end
end