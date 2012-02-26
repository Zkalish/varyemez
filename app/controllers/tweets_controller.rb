class TweetsController < ApplicationController       
  
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
  end
  
  
end
