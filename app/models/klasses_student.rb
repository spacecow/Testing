class KlassesStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :klass
end

# == Schema Information
#
# Table name: klasses_students
#
#  student_id :integer(4)
#  klass_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

