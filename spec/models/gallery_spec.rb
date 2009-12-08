require File.dirname(__FILE__) + '/../spec_helper'

describe Gallery do
  it "should be valid" do
    Gallery.new.should be_valid
  end
end
