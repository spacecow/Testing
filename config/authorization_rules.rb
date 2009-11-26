authorization do
  role :god do
    has_permission_on :events, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :registrants, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :user_sessions, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
		has_permission_on :events, :to => [:index, :show]
		has_permission_on :registrants, :to => [:new, :create]
		has_permission_on :user_sessions, :to => [:new, :create, :destroy]
		has_permission_on :users, :to => [:new, :create]
  end
  
  role :registrant do
  	includes :guest
  end
  
  role :student do
  	includes :guest
  end
end