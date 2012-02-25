#encoding:utf-8
class Contact < ActiveRecord::Base    
  require "unicode_utils/upcase"
   
  belongs_to :user 
  has_many :credits, :dependent => :destroy
               
  validates :user_id, :presence => true
  validates :first_name, :presence => {:message => "boş olmamalıdır."}
  validates :last_name, :presence => {:message => "boş olmamalıdır."}
  validates :email, :presence => {:message => "boş olmasınki borçlarını hatırlatalım."}, 
                   :uniqueness => {:message => "daha önce kaydedilmiş"}  
                   

  scope :borclular, where(["debt > 0"])      
  scope :alacaklilar, where(["debt < 0"])                
  scope :vadesine_gore_borclular, lambda { |tarih=nil| includes(:credits).where(['debt > 0 and credits.date_to <= ?', "#{tarih}"]) }
                   
  def name
    "#{first_name.capitalize} #{UnicodeUtils.upcase(last_name, :tr)}"    
  end                                                        
  
  def lock_status
    lock ? "Evet" : "Hayır"
  end
                   
end
