require File.dirname(__FILE__) + '/../spec_helper'

describe Invitation do
  it "should be valid" do
    Invitation.new.should be_valid
  end
end

# == Schema Information
#
# Table name: invitations
#
#  id              :integer(4)      not null, primary key
#  sender_id       :integer(4)
#  recipient_email :string(255)
#  token           :string(255)
#  sent_at         :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

