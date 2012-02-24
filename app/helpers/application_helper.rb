#encoding:utf-8
module ApplicationHelper  
  def guvenli_cikis
    if user_signed_in?
      content_tag :div, :class => "grid_2" do
        link_to "Güvenli Çıkış", destroy_user_session_path, :method => :delete
      end               
    end
  end
end
