require File.dirname(__FILE__) + '/../spec_helper'

describe Schedule do
  it "should be valid" do
    Schedule.new.should be_valid
  end
end
