class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients  user.mail_address_mobile
    from        "johan@reserve-gakuwarinet.com"
    subject     "Thank you for Registering"
    body        "Yeah!"
  end
  
  def invitation( invitation, signup_url )
    recipients  invitation.recipient_email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Invitation"
    body        :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute( :sent_at, Time.now )
  end  
end

