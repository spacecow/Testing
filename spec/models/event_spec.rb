require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  it "should be valid" do
    Event.new.should be_valid
  end
end
