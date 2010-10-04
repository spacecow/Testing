require File.dirname(__FILE__) + '/../spec_helper'

describe Kanji do
  it "should be valid" do
    Kanji.new.should be_valid
  end
end

# == Schema Information
#
# Table name: kanjis
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)
#

