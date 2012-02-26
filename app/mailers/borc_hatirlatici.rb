#encoding:utf-8
class BorcHatirlatici < ActionMailer::Base
  default from: "varyemezhesaptakip@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.borc_hatirlatici.borcunuzvar.subject
  #
  def borcunuzvar(email, name, debt)
    @email = email
    @name = name                   
    @debt = debt

    mail to: @email.downcase
    mail subject: "Borcunuz var hatırlatırım."
    mail bcc: "guzelmurat@gmail.com"
  end
end
