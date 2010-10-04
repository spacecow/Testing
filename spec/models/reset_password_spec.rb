require File.dirname(__FILE__) + '/../spec_helper'

describe ResetPassword do
  it "should be valid" do
    ResetPassword.new.should be_valid
  end
end

# == Schema Information
#
# Table name: reset_passwords
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  used       :boolean(1)      default(FALSE)
#

