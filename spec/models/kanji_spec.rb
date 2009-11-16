require File.dirname(__FILE__) + '/../spec_helper'

describe Kanji do
  it "should be valid" do
    Kanji.new.should be_valid
  end
end
