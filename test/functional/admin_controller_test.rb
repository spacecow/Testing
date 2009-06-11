require File.dirname(__FILE__)+'/../test_helper'

class AdminControllerTest < ActionController::TestCase
  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_login
    get :login
    assert_response :success
  end
  
  def test_index_without_user
    get :index
    assert_redirected_to :action => "login"
    assert_equal "Please log in", flash[:notice]
  end
  
  def test_index_with_user
    get :index, {}, { :user_name => people(:johan).user_name }
    assert_response :success
    assert_template "index"
  end
  
  def test_login
    johan = people(:johan)
    post :login, :user_name => johan.user_name, :password => 'secret'
    assert_redirected_to :controller => "klasses", :action => "index"
    assert_equal johan.user_name, session[:user_name]    
  end
  
  def test_bad_password
    johan = people(:johan)
    post :login, :user_name => johan.user_name, :password => 'wrong'
    assert_template "login"
  end  
end
