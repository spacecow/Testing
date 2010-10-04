require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  comment    :text
#  event_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)
#  todo_id    :integer(4)
#

