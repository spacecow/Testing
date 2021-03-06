class MailsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @mails = Mail.all.reverse
  end
  
  def box
    @recipients = current_user.recipients.reverse
  end  
  
  def show
  	@mail = Mail.find(params[:id])
    @mail.recipients.find_by_user_id( current_user.id ).update_attribute( :read, params[:read] ) unless params[:read].nil?
    @subject = @mail.subject.split('#')
    @message = @mail.message.split('#')
    @todo = Todo.find_by_title( @message[1] )
  end
  
  def new
  	@mail = Mail.new( :sender_id => current_user.id )
  end
  
  def create
  	@mail.subject = @mail.subject.gsub(/#/,'*')
  	@mail.message = @mail.message.gsub(/#/,'*')
    if @mail.save
    	@mail.update_attribute( :message, @mail.message.gsub("\n", "<br />"))
      flash[:notice] = t('notice.send_success',:object=>t(:mail).downcase)
      @mail.users.each do |user|
      	UserMailer.send_later( :deliver_mail, user, @mail.subject, @mail.message.gsub( "<br />", "\n" ))
    	end
      redirect_to box_mails_url
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
#  	params[:mail][:subject] = params[:mail][:subject].gsub(/#/,'*')
#  	params[:mail][:message] = params[:mail][:message].gsub(/#/,'*')
    if @mail.update_attributes(params[:mail])
      flash[:notice] = t('notice.update_success',:object=>t(:mail).downcase)
      redirect_to @mail
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @mail = Mail.find(params[:id])
    @mail.destroy
    flash[:notice] = t('notice.delete_success',:object=>t(:mail).downcase)
    redirect_to mails_url
  end
end
