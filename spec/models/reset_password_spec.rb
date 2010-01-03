require File.dirname(__FILE__) + '/../spec_helper'

describe ResetPassword do
  it "should be valid" do
    ResetPassword.new.should be_valid
  end
end
