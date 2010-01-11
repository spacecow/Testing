authorization do
  role :admin do
    has_permission_on :events, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :add_comment, :edit_comment, :move_comment]
    has_permission_on :registrants, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :user_sessions, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :users, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :new_event_register, :create_event_register, :edit_role, :update_role ]
    has_permission_on :comments, :to => [:new, :create, :edit, :update, :destroy]
    has_permission_on :settings, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :galleries, :to => [:index, :show, :edit]
    has_permission_on :photos, :to => [:new, :create, :show, :index, :update, :edit, :destroy ]
    has_permission_on :todos, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :add_comment, :edit_comment, :toggle_close]
    has_permission_on :votes, :to => [:new, :edit, :destroy, :index]
    has_permission_on :template_classes, :to => [:new, :create, :index, :show, :edit, :update, :destroy]
  end
  
  role :god do
  	includes :admin
  	has_permission_on :kanjis, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :glossaries, :to => [:quiz, :quiz_init, :check, :index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :onyomis, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :kunyomis, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :meanings, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :invitations, :to => [:new, :create, :deliver]
  	has_permission_on :mails, :to => [:show, :edit, :update, :index, :destroy]
  end
    
  role :guest do
#		has_permission_on :events, :to => [:index, :show]
#		has_permission_on :registrants, :to => [:new, :create]
		has_permission_on :reset_passwords, :to => [:new, :create]
		has_permission_on :user_sessions, :to => [:new, :create, :destroy]
		has_permission_on :users, :to => [:new, :create, :change_password, :update_password]
		has_permission_on :settings, :to => :toggle_user_language
#		has_permission_on :galleries, :to => :show
#		has_permission_on :photos, :to => :show
  end
  
  role :kanji_maniac do
		includes :guest
  	has_permission_on :kanjis, :to => [:index, :show]
  	has_permission_on :onyomis, :to => :show
  	has_permission_on :kunyomis, :to => :show
  	has_permission_on :meanings, :to => :show
  	has_permission_on :glossaries, :to => [:index, :quiz, :quiz_init, :new, :create, :check ]
  end  
	
	role :photographer do
		has_permission_on :photos, :to => [:new, :create, :update]	
		has_permission_on :photos, :to => [:edit, :destroy] do
			if_attribute :user => is { user }
    end
	end

  role :registrant do
  	includes :guest
  	has_permission_on :events, :to => [:index, :show, :add_comment, :edit_comment]
  	has_permission_on :users, :to => [:show, :edit, :update, :new_event_register, :create_event_register ]
  	has_permission_on :comments, :to => [:new, :create]
  	has_permission_on :comments, :to => [:edit, :update, :destroy] do
      if_attribute :user => is { user }
    end
		has_permission_on :photos, :to => :show
		has_permission_on :galleries, :to => :show
		has_permission_on :registrants, :to => [:new, :create]
		has_permission_on :todos, :to => [:index, :show, :new, :create, :add_comment, :edit_comment]
  	has_permission_on :todos, :to => [:edit, :update, :destroy, :toggle_close] do
      if_attribute :user => is { user }
    end		
    has_permission_on :votes, :to => [:new, :edit, :destroy]
  end

  role :observer do
		includes :registrant
		has_permission_on :template_classes, :to => [:show, :index]
	end
  
  role :student do
  	includes :registrant
  	has_permission_on :mails, :to => [:box]
  	has_permission_on :mails, :to => [:show] do
  		if_attribute :recipient => is { user }
  	end  	
  end  
  
  role :teacher do
  	includes :registrant
  	has_permission_on :mails, :to => [:box]
  	has_permission_on :mails, :to => [:show] do
  		if_attribute :recipient => is { user }
  	end
  end  
end