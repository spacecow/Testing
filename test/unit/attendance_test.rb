require File.dirname(__FILE__)+'/../test_helper'

class AttendanceTest < ActiveSupport::TestCase
end

# == Schema Information
#
# Table name: attendances
#
#  id         :integer(4)      not null, primary key
#  student_id :integer(4)
#  klass_id   :integer(4)
#  cancel     :boolean(1)      default(FALSE)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  chosen     :boolean(1)      default(FALSE)
#  version    :integer(4)      default(1)
#  late       :boolean(1)      default(FALSE)
#  absent     :boolean(1)      default(FALSE)
#

