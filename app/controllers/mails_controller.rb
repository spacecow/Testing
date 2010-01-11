class MailsController < ApplicationController
  filter_resource_access
  
  def index
    @mails = Mail.all.reverse
  end
  
  def box
    @mails = Mail.find_all_by_recipient_id( current_user.id ).reverse
  end  
  
  def show
  	@mail = Mail.find(params[:id])
    @mail.update_attribute( :read, params[:read] ) unless params[:read].nil?
    @subject = @mail.subject.split('#')
    @message = @mail.message.split('#')
    @todo = Todo.find_by_title( @message[1] )
  end
  
  def new
    @mail = Mail.new
  end
  
  def create
    @mail = Mail.new(params[:mail])
    if @mail.save
      flash[:notice] = "Successfully created mail."
      redirect_to mails_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @mail = Mail.find(params[:id])
  end
  
  def update
    @mail = Mail.find(params[:id])
    if @mail.update_attributes(params[:mail])
      flash[:notice] = "Successfully updated mail."
      redirect_to @mail
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @mail = Mail.find(params[:id])
    @mail.destroy
    flash[:notice] = "Successfully destroyed mail."
    redirect_to mails_url
  end
end
