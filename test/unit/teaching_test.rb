require 'test_helper'

class TeachingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: teachings
#
#  id          :integer(4)      not null, primary key
#  teacher_id  :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  klass_id    :integer(4)
#  status_mask :integer(4)      default(0)
#  current     :boolean(1)
#  cost        :string(255)
#

