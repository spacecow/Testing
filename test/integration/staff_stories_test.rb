require File.dirname(__FILE__)+'/../test_helper'

class StaffStoriesTest < ActionController::IntegrationTest
  fixtures :all

  def test_changing_a_class_for_a_student
    get "/students/edit_courses/1"
    assert_response :success

    #assert_redirected_to :controller => "admin", :action => "login"
    #post "/admin/login", :user_name => people(:johan).user_name, :password => 'secret'
		#assert_redirected_to edit_courses_students_path
  end
end
