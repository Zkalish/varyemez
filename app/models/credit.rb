#encoding:utf-8
class Credit < ActiveRecord::Base 
  belongs_to :contact
  
  validates :date_from, :presence => true
  validates :date_to, :presence => true                      
  validates :amount, :numericality => true
  validate :date_from_would_not_be_greater_then_date_to, :if => "date_from.present? && date_to.present?"
  
  after_create :credit_created             
  
  def date_from_would_not_be_greater_then_date_to
    if self.date_to < self.date_from
      errors.add :date_to, "daha eski bir tarih olamaz. Sence de mantıksız değil mi ?"
    end
  end                                                                                                  
 
  def borc_verilebilirmi
    #risk limiti kontrolü yapıyor ...     
    if self.contact.limit.nil? || self.contact.limit == 0
      # risk limiti tanımlı değil. O halde borç verilen tutar tahsil edilmeden yeni borç verilmemesi gerektiği uyarılacak ... 
      if self.credit_type == 1 && self.contact.debt > 0
        return false
      else
        return true
      end
    else
      if self.credit_type == 1 && (self.contact.limit < (self.amount + self.contact.debt))
        return false
      else
        return true
      end        
    end    
  end
  
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
