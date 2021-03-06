class TodosController < ApplicationController
	before_filter :find_comment_through_todo, :only => :edit_comment
	load_and_authorize_resource

	def find_comment_through_todo
  	@comment = Comment.find( params[:id] )
  	@todo = Todo.find( @comment.todo )
	end

  def index
  	@status = params[:status] || "open"
  	@subject = params[:subject] || "all"
  	@sort = params[:sort] || "created_at"
  	@order = params[:order] || "descending"
  	@setting = Setting.find_by_name( "main" )
    if @status == "is_closed"
    	if @subject == "all"
    		@todos = Todo.all( :conditions => ["closed = ?", true] )
    	else
  			@todos = Todo.with_subject( @subject ).reject{|e| !e.closed}
			end
  	else
  		if @subject == "all"
    		@todos = Todo.all( :conditions => ["closed = ?", false])
    	else
    		@todos = Todo.with_subject( @subject ).reject(&:closed)
    	end
    end
    @todos = @todos.sort_by{|e| e.send( @sort )}
    if @order == "descending"
    	@todos = @todos.reverse
    end
  end
  
  def show
  	@setting = Setting.find_by_name( "main" )
  	@todo = Todo.find( params[:id] )
  	@comment = Comment.new
  end
  
  def new
  	@todo = Todo.new(
  		:description => params[:description],
  		:user_id => ( params[:user_id].blank? ? current_user.id : params[:user_id] )
  	)
  	@comment_id = params[:comment_id]
  end
  
  def create
  	@comment_id = params[:comment_id]
		#@todo.user_id = current_user.id
		#params[:todo][:description] = params[:todo][:description].gsub("\n", "<br />");
		@todo = Todo.new( params[:todo] )
    if @todo.save
    	@todo.update_attribute( :description, params[:todo][:description].gsub("\n", "<br />"))
      flash[:notice] = t('notice.create_success', :object=>t(:todo).downcase )
      send_mail( "created", "todo", { :author => false })
      if( params[:comment_id].blank? )
      	redirect_to todos_path
      else
      	comment = Comment.find( params[:comment_id] )
      	event = Event.find( comment.event_id )
      	comment.destroy
      	redirect_to event
    	end
    else
      render :action => 'new'
    end
  end
  
  def edit
  	@todo = Todo.find( params[:id] )
  	@todo.description = @todo.description.gsub("<br />", "\n");
  end
  
  def update
  	#params[:todo][:description] = params[:todo][:description].gsub("\n", "<br />");
  	@todo = Todo.find( params[:id] )
    if @todo.update_attributes(params[:todo])
    	@todo.update_attribute( :description, params[:todo][:description].gsub("\n", "<br />"))
      flash[:notice] = t('notice.update_success', :object=>t(:todo).downcase )
      send_mail( "updated", "todo", { :author => false })
      redirect_to todos_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
  	@todo = Todo.find( params[:id] )
    @todo.destroy
    flash[:notice] = t('notice.delete_success', :object=>t(:todo).downcase )
    redirect_to todos_url
  end
  
  def add_comment
		@todo = Todo.find( params[:id] )
  	@comment = Comment.new( params[:comment] )
  	@comment.comment = @comment.comment.gsub("\n", "<br />");
  	if @comment.save		
			send_mail( "added", "comment", { :comments => true, :content => @comment.comment })
    else    		
      flash.now[:error] = t('error.blank',:object=>t(:comment).downcase )
    end
		respond_to do |wants|
			wants.html { redirect_to @todo }
			wants.js
		end
  end
  
  def edit_comment
  	@setting = Setting.find_by_name( "main" )
  	respond_to do |wants|
			wants.html
			wants.js
  	end	
  end
  
  def toggle_close
  	@todo = Todo.find( params[:id] )
  	@todo.update_attribute( :closed, !@todo.closed )
  	send_mail( @todo.closed ? "closed" : "reopened", "todo", { :comments => true, :votes => true })
  	redirect_to :back
  end
  
private
  
  def send_mail( message, category, opts={} )
  	opts = { :author => true }.merge!( opts )
  	recipients = []
  	johan = User.with_role(:god).first
  	@todo.comments.each{ |comment| recipients.push comment.user } if opts[:comments]
  	@todo.votes.each{ |vote| recipients.push vote.user } if opts[:votes]
  	recipients.push @todo.user if opts[:author]
  	recipients.push johan
  	recipients = recipients.reject{|e| e==nil}.uniq.reject{|e| e==current_user }
  	
  	mail = Mail.create!(
    	:sender_id => current_user.id,
    	#:recipient_id => user.id,
    	:subject => "#{message}##{category}",
    	:message => "#{category.pluralize}.#{message}##{@todo.title}##{category=='todo'?'':'todo'}##{opts[:content]}"
    ) unless recipients.empty?  	
    
  	recipients.each do |user|
  		Recipient.create!( :mail_id=>mail.id, :user_id=>user.id )
  		UserMailer.send_later( :deliver_notification,
  			user,
  			t(message,:object=>t(category)),
  		  t("#{category.pluralize}.#{message}",:name=>current_user,:subject=>@todo.title,:object=>category=='todo'?'':'todo')+"\n\n#{opts[:content].blank? ? '' : opts[:content].gsub("<br />", "\n")}",
  		  login_user_url,
  		  user.username
  		)    
    end
  end	  
end