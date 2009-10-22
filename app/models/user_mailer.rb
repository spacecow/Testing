class UserMailer < ActionMailer::Base

  def registration_confirmation(user)
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Thank you for Registering"
    body        "Yeah!"
  end
end
