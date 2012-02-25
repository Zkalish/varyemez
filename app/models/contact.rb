#encoding:utf-8
class Contact < ActiveRecord::Base    
  require "unicode_utils/upcase"
   
  belongs_to :user 
  has_many :credits, :dependent => :destroy
               
  validates :user_id, :presence => true
  validates :first_name, :presence => {:message => "boş olmamalıdır."}
  validates :last_name,  :presence => {:message => "boş olmamalıdır."}
  validates :email, :presence => {:message => "boş olmasınki borçlarını hatırlatalım."}, 
                    :uniqueness => {:message => "daha önce kaydedilmiş"}     
                   
  def name
    "#{first_name.capitalize} #{UnicodeUtils.upcase(last_name, :tr)}"    
  end                                                        
  
  def lock_status
    lock ? "Evet" : "Hayır"
  end 
  
  def self.refresh_debt(contact)
    borc = contact.credits.where(:credit_type => 1).sum(:amount)
    alacak = contact.credits.where(:credit_type => 2).sum(:amount)
    contact.update_attributes(:debt => borc-alacak)
  end
                   
end
