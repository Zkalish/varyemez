#encoding:utf-8
class HesapDokumPdf < Prawn::Document

  def initialize(contact, view)   
    super(top_margin: 50)   
    
    @contact = contact
    @view = view  
    kisi_bilgileri
    line_items
    
  end             
  
  def kisi_bilgileri   
    font_families.update("arial" => {
                                        :normal => "#{Rails.root}/public/arial.ttf",
                                        :bold => "#{Rails.root}/public/arial_bold.ttf"
                                        
                                    })
    font "arial"  do
      text "#{@contact.name} - Hesap Dökümü", :size => 30, :style => :bold   
      text "#{@contact.email}"
    end
  end                                                  
  
  def line_items     
     move_down 30    
     font_families.update("arial" => {:normal => "#{Rails.root}/public/arial.ttf", :bold => "#{Rails.root}/public/arial.ttf"})
     font "arial" do
       table line_item_rows do
         row(0).font_style = :bold
         columns(1..3).align = :right
         self.row_colors = ["DDDDDD", "FFFFFF"]
         self.header = true
       end            
     end
   end

   def line_item_rows
     [["İşlem Tarihi", "Vade Tarihi", "Borcunuz", "Alacağınız", "Açıklama"]] +
     @contact.credits.map do |contact|
       [contact.date_from.strftime("%d-%m-%Y"), contact.date_to.strftime("%d-%m-%Y"), para_birimi(contact.borc), para_birimi(contact.alacak), contact.description]
     end
   end    
   
   def para_birimi(money)        
     @view.number_to_currency(money, { :precision => 2, :unit => "", :delimiter => ".", :separator => "," }).to_s + " TL" unless money.blank?
   end
  
  
end