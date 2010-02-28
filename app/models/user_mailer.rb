class UserMailer < ActionMailer::Base
	def mail( user, title, message )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     title
    body        message
	end

  def notification(user, topic, message, login_user_url, username )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     topic
    body        :message => message, :login_user_url => login_user_url, :username => username
  end

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
  
  def reset_password( reset_password, reset_password_url )
    recipients  reset_password.user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Password Reset"
    body        :reset_password => reset_password, :reset_password_url => reset_password_url
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
  
  def update_0_16( user )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.16"
    body
  end
  
  def update_0_17( user )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.17"
    body				:username => user.username
  end     
  
  def update_0_17b( user, login_user_url, username )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.17b"
    body				:user => user, :login_user_url => login_user_url, :username => username
  end       

  def update_0_19( user, login_user_url, username )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.19"
    body				:user => user, :login_user_url => login_user_url, :username => username
  end    
  
  def update_0_20( user, login_user_url, username )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.20"
    body				:user => user, :login_user_url => login_user_url, :username => username
  end    
  
  def update_0_21( user, login_user_url, username )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.21"
    body				:user => user, :login_user_url => login_user_url, :username => username
  end
  
  def update_0_25( user, login_user_url, username )
    recipients  user.email
    from        "johan@reserve-gakuwarinet.com"
    subject     "Update, Version 0.25"
    body				:user => user, :login_user_url => login_user_url, :username => username
  end         
end

