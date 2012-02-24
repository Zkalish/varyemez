#encoding:utf-8
module ApplicationHelper  
  
  def guvenli_cikis
    if user_signed_in?
      content_tag :div, :class => "grid_2 guvenlicikis" do
        link_to "Güvenli Çıkış", destroy_user_session_path, :method => :delete
      end               
    end
  end
  
  def avatar(email)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}?s=36&d=mm"        
  end

end
