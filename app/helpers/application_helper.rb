#encoding:utf-8
module ApplicationHelper  
  
  def guvenli_cikis
    if user_signed_in?
      content_tag :div, :class => "grid_2 guvenlicikis" do
        link_to "Güvenli Çıkış", destroy_user_session_path, :method => :delete
      end               
    end
  end
  
  def avatar(email, size)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?s=#{size}&d=mm"        
  end    
  
  def para_birimi(money)        
    return number_to_currency(money, { :precision => 2, :unit => "", :delimiter => ".", :separator => "," }).to_s + " TL" unless money.blank?
  end 
  
  def tarih_format(date)
    return date.strftime("%d-%m-%Y") if date
  end

end
