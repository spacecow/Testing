require 'test_helper'

class ScheduledUnitTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: scheduled_units
#
#  id          :integer(4)      not null, primary key
#  schedule_id :integer(4)
#  unit_id     :integer(4)
#  start_time  :time
#  end_time    :time
#  date        :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

