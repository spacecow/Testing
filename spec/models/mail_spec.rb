require File.dirname(__FILE__) + '/../spec_helper'

describe Mail do
  it "should be valid" do
    Mail.new.should be_valid
  end
end

# == Schema Information
#
# Table name: mails
#
#  id         :integer(4)      not null, primary key
#  sender_id  :integer(4)
#  subject    :string(255)
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

