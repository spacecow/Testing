require File.dirname(__FILE__) + '/../spec_helper'

describe Unit do
  it "should be valid" do
    Unit.new.should be_valid
  end
end
