class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new
    
    if user.role? :god
  		can :manage, :all	
		else
			can [:new, :create, :destroy], UserSession
  		if user.role? :registrant
	  		can :read, Event
	  	elsif user.role? :observer
	  		can :read, Event
	  	elsif user.role? :admin
	  		can :manage, Event
	  	end
	  	if( user.role? :student )||( user.role? :teacher )
	  		can :show, User
	  		can :read, Todo
	  		can :box, Mail
	  		can :show, Mail do |mail|
	  			mail.try(:recipient) == user
	  		end	  	
  		end
  	end
  end
end
