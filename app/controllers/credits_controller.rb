#encoding:utf-8
class CreditsController < ApplicationController
  before_filter :get_contact
  
  def get_contact
    @contact = Contact.find(params[:contact_id])
  end   
  
  def index
    @credits = @contact.credits
    respond_to do |format|
      format.pdf do
        pdf = HesapDokumPdf.new(@contact, view_context)
        send_data pdf.render, :filename => "#{@contact.name} Hesap Dökümü", :type => "application/pdf", :dispoisition => "inline"
      end
    end
  end 
  
  def new
    @credit = @contact.credits.build
  end
  
  def create
    @credit = @contact.credits.build(params[:credit]) 
    
    # limit değerleri kontrol edilecek ve uyarı varsa verilecek.
    if !params[:accept]
      unless @credit.borc_verilebilirmi
        flash[:alert] = "Borç vermenizi şiddetle tavsiye etmiyorum."
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