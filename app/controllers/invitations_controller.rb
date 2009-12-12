class InvitationsController < ApplicationController
  filter_resource_access
  
  def new
  end
  
  def create
    @invitation.sender = current_user
    if @invitation.save
    	UserMailer.deliver_invitation( @invitation, signup_url( @invitation.token ))
      flash[:notice] = t('invitations.sent')
      redirect_to events_path
    else
      render :action => 'new'
    end
  end
end
