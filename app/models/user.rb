#encoding:utf-8
class User < ActiveRecord::Base  
  has_many :authentications
  # To use devise-twitter don't forget to include the :twitter_oauth module:
  # e.g. devise :database_authenticatable, ... , :twitter_oauth

  # IMPORTANT: If you want to support sign in via twitter you MUST remove the
  #            :validatable module, otherwise the user will never be saved
  #            since it's email and password is blank.
  #            :validatable checks only email and password so it's safe to remove

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :oauth_provider, :oauth_uid, :remember_me        
  
  validates :email, :uniqueness => {:message => "zaten daha önce kayıt olmuş."}                                          
  
  def apply_omniauth(omniauth)
    self.password = Devise.friendly_token[0,20]                     
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
                   
end