require File.dirname(__FILE__) + '/../spec_helper'

describe Word do
  it "should be valid" do
    Word.new.should be_valid
  end
end
