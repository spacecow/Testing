class Ability
  include CanCan::Ability

  def initialize( user )
		can :toggle_user_language, Setting
		can :create, UserSession
		can :create, User
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
	  	
	    if user.role? :god
				can :manage, :all	
	  	elsif( user.role? :student ) || ( user.role? :teacher ) || ( user.role? :observer ) || ( user.role? :admin )
	  		can :create, Comment
	  		can [:update, :destroy], Comment do |comment|
  				comment.try(:user) == user
  			end
	  		can :show, User
	  		can [:read, :add_comment, :edit_comment], Todo
  			can [:update, :destroy, :toggle_close], Todo do |todo|
  				todo.try(:user) == user
  			end
  			can [:add_comment, :edit_comment], Event
	  		can :box, Mail
	  		can :show, Mail do |mail|
	  			mail.try(:recipient) == user
	  		end	  	
  		end
  		if user.role? :observer
	  		can :read, [Event, Todo, Photo, Todo, User]
	  	elsif user.role? :admin
	  		can :manage, [Event, Todo, User, Setting, Comment, Vote, Gallery, Photo]
	  	end
			if user.role? :photographer
				can [:create, :update], Photo
				can [:edit, :destroy], Photo do |photo|
					photo.try(:user) == user
				end
			end	  	
  	end
  end
end
