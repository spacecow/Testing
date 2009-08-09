require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeachingsController do

  #Delete these examples and add some real ones
  it "should use TeachingsController" do
    controller.should be_an_instance_of(TeachingsController)
  end


  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end
end
