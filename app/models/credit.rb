class Credit < ActiveRecord::Base 
  belongs_to :contact  
  
  after_create :credit_created           
  
  
  def credit_created
    if self.credit_type == 1 # borç verilmiş      
      self.contact.update_attributes(:debt => self.contact.debt + self.amount)           
    else # borcunu ödemiş
      self.contact.update_attributes(:debt => self.contact.debt - self.amount)      
    end
  end                  
  
  def borc
    self.amount if credit_type == 1
  end
  
  def alacak                       
    self.amount if credit_type == 2
  end                                  
  
end
