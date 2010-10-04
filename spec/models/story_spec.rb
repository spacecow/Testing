require File.dirname(__FILE__) + '/../spec_helper'

describe Story do
  it "should be valid" do
    Story.new.should be_valid
  end
end

# == Schema Information
#
# Table name: stories
#
#  id         :integer(4)      not null, primary key
#  japanese   :text
#  english    :text
#  created_at :datetime
#  updated_at :datetime
#

