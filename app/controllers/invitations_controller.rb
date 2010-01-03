class InvitationsController < ApplicationController
  filter_access_to :all
  
  def new
  	@invitation = Invitation.new
  	@version = Setting.find_by_name( "main" ).version.gsub(/\./, '_')
  	#@users = User.all
  	@users = [ User.first ]
  end
  
  def create
		@invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
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
  	func = "deliver_update_#{params[:version]}".to_sym
		@users = User.find( params[:users] )
#  	UserMailer.send( func, User.first, login_user_url, User.first.username )
  	@users.each do |user|
  		UserMailer.send( func, user, login_user_url, user.username ) if user.info_update
		end
    flash[:notice] = t('invitations.sent')
		redirect_to new_invitation_path  	
  end
end
