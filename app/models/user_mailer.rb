class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
    recipients  user.email
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
  
  def update_0_11( user )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.11"
    body        
  end  

  def update_0_12( user )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.12"
    body        
  end

  def update_0_15( user )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.15"
    body
  end
  
  def update_0_15b( user )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.15b"
    body
  end    
end

