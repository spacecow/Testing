require File.dirname(__FILE__) + '/../spec_helper'
 
describe SchedulesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Schedule.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Schedule.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Schedule.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(schedule_url(assigns[:schedule]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Schedule.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Schedule.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Schedule.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Schedule.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Schedule.first
    response.should redirect_to(schedule_url(assigns[:schedule]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    schedule = Schedule.first
    delete :destroy, :id => schedule
    response.should redirect_to(schedules_url)
    Schedule.exists?(schedule.id).should be_false
  end
end
