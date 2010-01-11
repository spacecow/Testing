require File.dirname(__FILE__) + '/../spec_helper'

describe Mail do
  it "should be valid" do
    Mail.new.should be_valid
  end
end
