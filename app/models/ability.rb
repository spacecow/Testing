class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new
    
    if user.role? :god
  		can :manage, :all	
		else
			can [:create, :destroy], UserSession
			can [:create], User
	  	if( user.role? :student )||( user.role? :teacher )||( user.role? :observer )||( user.role? :admin )
	  		can :create, Comment
	  		can [:update, :destroy], Comment do |comment|
  				comment.try(:user) == user
  			end
  			can :show, Photo
	  		can :show, User do |u|
  				u == user
				end
	  		can [:read, :add_comment, :edit_comment], Todo
  			can [:update, :destroy, :toggle_close], Todo do |todo|
  				todo.try(:user) == user
  			end
	  		can :box, Mail
	  		can :show, Mail do |mail|
	  			mail.try(:recipient) == user
	  		end	  	
  		end
  		if user.role? :registrant
	  		can :read, Event
	  	elsif user.role? :observer
	  		can :read, [Event,Todo]
	  	elsif user.role? :admin
	  		can :manage, [Event, Todo, User, Setting, Comment, Vote, Gallery, Photo]
	  	end
  	end
  end
end
