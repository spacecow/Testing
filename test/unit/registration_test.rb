require File.dirname(__FILE__)+'/../test_helper'

class RegistrationTest < ActiveSupport::TestCase
end

# == Schema Information
#
# Table name: registrations
#
#  id         :integer(4)      not null, primary key
#  student_id :integer(4)
#  course_id  :integer(4)
#  cancel     :boolean(1)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

