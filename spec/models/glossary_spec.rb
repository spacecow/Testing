require File.dirname(__FILE__) + '/../spec_helper'

describe Glossary do
  it "should be valid" do
    Glossary.new.should be_valid
  end
end
