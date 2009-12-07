authorization do
  role :admin do
    has_permission_on :events, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :registrants, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :user_sessions, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :users, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :new_event_register, :create_event_register ]
    has_permission_on :comments, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :settings, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :god do
  	includes :admin
  	has_permission_on :kanjis, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :glossaries, :to => [:quiz, :quiz_init, :index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :onyomis, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :kunyomis, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  	has_permission_on :meanings, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
		has_permission_on :events, :to => [:index, :show]
		has_permission_on :registrants, :to => [:new, :create]
		has_permission_on :user_sessions, :to => [:new, :create, :destroy]
		has_permission_on :users, :to => [:new, :create]
		has_permission_on :settings, :to => :toggle_user_language
  end
  
  role :kanji_maniac do
		includes :guest
  	has_permission_on :kanjis, :to => [:index, :show]
  	has_permission_on :onyomis, :to => :show
  	has_permission_on :kunyomis, :to => :show
  	has_permission_on :meanings, :to => :show
  	has_permission_on :glossaries, :to => [:index, :quiz, :quiz_init, :new, :create]
  end  

  role :registrant do
  	includes :guest
  	has_permission_on :users, :to => [:edit, :update, :new_event_register, :create_event_register ]
  end
  
  role :student do
  	includes :guest
  end
end