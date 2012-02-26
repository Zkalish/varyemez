class MailsendersController < ApplicationController
  def create                     
    @email = params[:email]
    @name = params[:name]                    
    @debt = params[:debt]
    BorcHatirlatici.borcunuzvar(@email, @name, @debt).deliver
  end
end
