class Ability
  include CanCan::Ability

  def initialize( user )
		can :toggle_user_language, Setting
		can :create, UserSession
		can [:create, :change_password, :update_password], User
		can :read, Event
		can :show, [Photo, Gallery]
		can :create, ResetPassword

		if user.nil?
		else
			can :destroy, UserSession
			can [:new_event_register, :create_event_register], User
			can :update, User do |u|
				u == user
			end
  		can :create, Registrant
	  	
	  	if( user.role? :student ) || ( user.role? :teacher ) || ( user.role? :observer ) || ( user.role? :admin )
	  		can :create, Comment
	  		can [:update, :destroy], Comment do |comment|
  				comment.try(:user) == user
  			end
	  		can :show, User
	  		can [:create, :read, :add_comment, :edit_comment], Todo
  			can [:update, :destroy, :toggle_close], Todo do |todo|
  				todo.try(:user) == user
  			end
  			can [:new, :edit, :destroy], Vote
  			can [:add_comment, :edit_comment], Event
	  		can [:box, :create], Mail
	  		can :show, Mail do |mail|
	  			mail.recipients.map(&:user).include?( user )
	  		end
	  		can :read, Klass
	  		can :show, Course
  		end
			if user.role? :photographer
				can [:create, :update], Photo
				can [:edit, :destroy], Photo do |photo|
					photo.try(:user) == user
				end
			end
			if user.role? "beta-tester"
			end
	  	if user.role? :student
	  		can [:reserve,:update_reserve], User do |u|
  				u == user
  			end
			end
	  	if user.role? :teacher
	  		can :confirm, User do |u|
  				u == user
  			end
			end			
  		if user.role? :observer
	  		can :read, [Event, Todo, Photo, Todo, User, TemplateClass, Registrant, Klass, Course]
	  	end
  		if user.role? :admin
	  		can :manage, [Event, Todo, User, Setting, Comment, Vote, Gallery, Photo, TemplateClass, Registrant, Klass, Course, Mailer]
	  	end
	  	if user.role? :god
				can :manage, :all
			end
  	end
  end
end
