require File.dirname(__FILE__) + '/../spec_helper'

describe Gallery do
  it "should be valid" do
    Gallery.new.should be_valid
  end
end

# == Schema Information
#
# Table name: galleries
#
#  id          :integer(4)      not null, primary key
#  event_id    :integer(4)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

