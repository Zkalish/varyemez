class CreditsController < ApplicationController
  def create
    @credit = Credit.new(params[:credit])
    @credit.contact_id = params[:contact_id]
    @credit.save    
  end
end