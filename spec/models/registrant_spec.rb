require File.dirname(__FILE__) + '/../spec_helper'

describe Registrant do
  it "should be valid" do
    Registrant.new.should be_valid
  end
end

# == Schema Information
#
# Table name: registrants
#
#  id         :integer(4)      not null, primary key
#  event_id   :integer(4)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)
#

