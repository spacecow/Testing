require 'test_helper'

class CoursesTeacherTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: courses_teachers
#
#  id         :integer(4)      not null, primary key
#  teacher_id :integer(4)
#  course_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  chosen     :boolean(1)      default(FALSE)
#  cost       :string(255)
#

