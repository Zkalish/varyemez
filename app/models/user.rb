#encoding:utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable, 
         :omniauthable  
 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me        
  
  validates :email, :uniqueness => {:message => "zaten daha önce kayıt olmuş."}                                          
 
 
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password. 
      User.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end 
  
      
  
  def self.find_for_twitter_oauth(oauth_hash, signed_in_resource=nil)
      uid = oauth_hash['uid']
      if user = User.find_by_oauth_provider_and_oauth_uid('twitter', uid)
        user
      else 
        User.create(:password => Devise.friendly_token[0,20],
                    :oauth_provider => "twitter", 
                    :oauth_uid => oauth_hash['uid'])
      end
                                                                                                                         


=begin
    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"]
        end
      end
    end 
=end
end