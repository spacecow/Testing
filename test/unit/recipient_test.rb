require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: recipients
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  mail_id    :integer(4)
#  read       :boolean(1)      default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

