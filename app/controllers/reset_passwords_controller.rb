class ResetPasswordsController < ApplicationController
  filter_resource_access
  
  def new
    @reset_password = ResetPassword.new
  end
  
  def intro  	
  end
  
  def create
    @reset_password = ResetPassword.new(params[:reset_password])
    if @reset_password.save
      @reset_password.update_attribute( :user_id, User.find_by_username( @reset_password.username ).id ) unless @reset_password.username.blank?
      @reset_password.update_attribute( :user_id, User.find_by_email( @reset_password.email ).id ) unless @reset_password.email.blank?
      UserMailer.deliver_reset_password( @reset_password, reset_password_url( @reset_password.token ))
      flash[:notice] = t('notice.mail_sent')
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
