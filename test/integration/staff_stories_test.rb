require File.dirname(__FILE__)+'/../test_helper'

class StaffStoriesTest < ActionController::IntegrationTest
  fixtures :all

  def test_changing_a_class_for_a_student
    #get "/students/edit_courses/1"
    #assert_response :success

    #assert_redirected_to :controller => "admin", :action => "login"
    #post "/admin/login", :user_name => people(:johan).user_name, :password => 'secret'
		#assert_redirected_to edit_courses_students_path
  end
  
  context "A user" do
		should "be taken to the login section if not logged in" do
		  get "/klasses"
			assert_redirected_to :controller => "admin", :action => "login"
	  end
	  should "be redirected to the page he tried to visit before he was forced to log in" do
			post "/admin/login", :user_name => people(:johan).user_name, :password => 'secret'
			assert_redirected_to klasses_path
		end
		should "be displayed with todays date when looking up a klass" do
			p @klass_date
	  end
	end
end
