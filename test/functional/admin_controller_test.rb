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
    get :index, {}, { :user_name => people(:aya).user_name }
    assert_response :success
    assert_template "index"
  end
  
  def test_login
    aya = people(:aya)
    post :login, :user_name => aya.user_name, :password => 'secret'
    assert_redirected_to :controller => "klasses", :action => "index"
    assert_equal aya.user_name, session[:user_name]    
  end
  
  def test_bad_password
    aya = people(:aya)
    post :login, :user_name => aya.user_name, :password => 'wrong'
    assert_template "login"
  end  
end
