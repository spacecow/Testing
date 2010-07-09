ActionController::Routing::Routes.draw do |map|
  map.resources :stories, :collection => {:quiz=>:get, :quiz_init=>:get}, :member=>{:check=>:put}

  map.resources :words

  map.mailer 'mailer', :controller => 'mailer', :action => 'index'
  map.send_mail 'send_mail', :controller => 'mailer', :action => 'send_mail'
  map.resources :mails, :collection => { :box => :get }

  map.resources :reset_passwords

	map.resources :votes
  map.resources :todos, :member => {:add_comment => :put, :edit_comment => :get, :toggle_close => :get}
	map.resources :events, :member => {:add_comment => :put, :edit_comment => :get, :move_comment => :get}

  map.resources :invitations, :collection => { :deliver => :get }
	map.signup '/signup/:invitation_token', :controller => 'users', :action => 'new'
	map.reset_password '/change_password/:token', :controller => 'users', :action => 'change_password'

  map.resources :galleries
  map.resources :photos

  map.resources :kanjis
	map.resources :onyomis
	map.resources :kunyomis
	map.resources :meanings

  map.resources :glossaries, :collection => { :quiz => :get, :quiz_init => :get }, :member => { :check => :put }

	map.login_user '/login_user/:username', :controller => 'user_sessions', :action => 'new'
	map.login_user '/login_user', :controller => "user_sessions", :action => "new"
	map.logout_user "logout_user", :controller => "user_sessions", :action => "destroy"
	map.mypage '/mypage', :controller => "events", :action => "index"
	
	map.toggle_user_language "toggle_user_language", :controller => "settings", :action => "toggle_user_language", :method => :put

  map.resources :user_sessions

  map.resources :users,
  :member => {
  	:edit_courses=>:get,
  	:reserve=>:get,
  	:update_reserve=>:put,
  	:confirm=>:get,
  	:update_confirm=>:put,
  	:new_event_register => :post,
  	:create_event_register => :put,
  	:edit_role => :get,
  	:update_role => :put,
  	:daily_teacher_reminder => :get,
  	:weekly_teacher_schedule => :get,},
  :collection => {
  	:edit_multiple => :post,
  	:update_multiple =>:put,
  	:salary => :get,
  	:change_password => :get,
  	:update_password => :put }

	map.resources :comments
  map.resources :registrants
  map.resources :kanjis, :member => {:check => :get}
	map.resources :scheduled_units
  map.resources :schedules
  map.resources :settings
  map.resources :schedules
  map.resources :units
  map.resources :attendances
  map.resources :classrooms
  map.resources :courses
  map.resources :course_times
  map.resources :docs
  map.resources :klasses, :collection => { :add_course => :get, :update_individual => :put }
  map.resources :people
  map.resources :students, :collection => { :edit_multiple => :get, :update_multiple => :put }, :member => { :edit_courses => :get, :update_courses => :put, :edit_klasses => :get, :update_klasses => :put }
	map.resources :tags
  map.resources :teachers, :collection => { :edit_multiple => :get, :update_multiple => :put }, :member => { :edit_courses => :get, :update_courses => :put }
  map.resources :teachings,
    :collection => {
	  	:edit_multiple => :post,
	  	:update_multiple =>:put
  	}
  map.resources :template_classes, :collection => { :add_course => :get }
  map.login 'login', :controller => 'admin', :action => 'login'
  map.logout 'logout', :controller => 'admin', :action => 'logout'
  map.root :login_user

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
