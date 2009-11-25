authorization do
  role :admin do
    has_permission_on :events, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :registrants, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :guest do
		has_permission_on :events, :to => [:index, :show]
		has_permission_on :registrants, :to => :new
  end
end