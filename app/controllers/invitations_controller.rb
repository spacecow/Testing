class InvitationsController < ApplicationController
  load_and_authorize_resource
  
  def new
  	@invitation = Invitation.new
  	@version = Setting.find_by_name( "main" ).version.gsub(/\./, '_')
  	#@users = User.all
  	@users = [ User.first ]
  end
  
  def create
		@invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
  	#@users = User.all
  	@users = [ User.first ]    
    if @invitation.save
    	UserMailer.deliver_invitation( @invitation, signup_url( @invitation.token ))
      flash[:notice] = t('invitations.sent')
      redirect_to new_invitation_path
    else
      @version = Setting.find_by_name( "main" ).version.gsub(/\./, '_')
      render :action => 'new'
    end
  end

  def deliver
		@users = User.find( params[:users] )
		
		mess = ""
		File.open "app/views/user_mailer/update_#{params[:version]}.erb", 'r' do |f|
			f.readlines.each do |line|
				break if line=="//johan\n"
				mess += line
			end
		end
		
		p mess.gsub("\n", "<br />")
  	mail = Mail.create!(
    	:sender_id => current_user.id,
    	:subject => "version_update#version##{params[:version].gsub(/_/,'.')}",
    	:message => mess.gsub("\n", "<br />")
    )
    @users.each do |user|
  		Recipient.create!( :mail_id=>mail.id, :user_id=>user.id )
  	end
    
  	func = "deliver_update_#{params[:version]}".to_sym
#  	UserMailer.send( func, User.first, login_user_url, User.first.username )
  	@users.each do |user|
  		UserMailer.send( func, user, login_user_url, user.username ) if user.info_update
		end

    flash[:notice] = t('invitations.sent')
		redirect_to new_invitation_path  	
  end
end
