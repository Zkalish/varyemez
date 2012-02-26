require 'test_helper'

class BorcHatirlaticiTest < ActionMailer::TestCase
  test "borcunuzvar" do
    mail = BorcHatirlatici.borcunuzvar
    assert_equal "Borcunuzvar", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
