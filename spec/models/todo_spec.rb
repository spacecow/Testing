require File.dirname(__FILE__) + '/../spec_helper'

describe Todo do
  it "should be valid" do
    Todo.new.should be_valid
  end
end
