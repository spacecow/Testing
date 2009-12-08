require File.dirname(__FILE__) + '/../spec_helper'
 
describe GalleriesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Gallery.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Gallery.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Gallery.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(gallery_url(assigns[:gallery]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Gallery.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Gallery.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Gallery.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Gallery.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Gallery.first
    response.should redirect_to(gallery_url(assigns[:gallery]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    gallery = Gallery.first
    delete :destroy, :id => gallery
    response.should redirect_to(galleries_url)
    Gallery.exists?(gallery.id).should be_false
  end
end
