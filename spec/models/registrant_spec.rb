require File.dirname(__FILE__) + '/../spec_helper'

describe Registrant do
  it "should be valid" do
    Registrant.new.should be_valid
  end
end
