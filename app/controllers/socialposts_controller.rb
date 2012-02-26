#encoding:utf-8
class SocialpostsController < ApplicationController       
  
  def create  
    #twitter üzerinde borçlu olanı ifşa ediyoruz ... 
    twitter = current_user.authentications.find_by_provider("twitter")
    if twitter.present?
      Twitter.configure do |config|
        config.consumer_key = "cxjXuVAQwYtclpugaNq7wA"
        config.consumer_secret = "tWnjikJiGyyowmBYZCeq3aXRB13LCZp4QXiFQEZk"
        config.oauth_token = twitter.token
        config.oauth_token_secret = twitter.token_secret
      end
      Twitter.update(params[:tweet])     
    end 
    
    #facebook üzerinde borçlu olanı ifşa ediyoruz ... 
    facebook = current_user.authentications.find_by_provider("facebook")
    if facebook.present?    
        me = FbGraph::User.me(facebook.token)
        me.feed!(
          :message => "#{params[:tweet]}",
          :link => 'http://varyemez.herokuapp.com',
          :name => 'Borç ifşası',
          :description => 'Borcunu ifşa ediyorum.'
        )
    end
  end
  
  
end
