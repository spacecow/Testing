require 'test_helper'

class BankTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: banks
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  branch      :string(255)
#  account     :string(255)
#  signup_name :string(255)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

