#encoding:utf-8
module ContactsHelper
  
  def lock_action(contact)
    if contact.lock_status == "Hayır"
      link_to "Kilitle", lock_contact_path(contact.id), :method => :post
    else
      link_to "Kilidi Aç", lock_contact_path(contact.id), :method => :post
    end
  end
   
end
