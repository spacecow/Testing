require File.dirname(__FILE__)+'/../test_helper'

class StudentTest < ActiveSupport::TestCase
  fixtures :klasses, :attendances
  
  def test_find_attendance
    student = students( :kurosawa )
    klass = klasses( :kurosawa_class )
    attendance = attendances( :kurosawa_attendance )
    assert_equal student.find_attendance_by_klass_id( klass ), attendance
    assert_equal student.is_canceled?( klass ), false
  end
  
  def test_canceling
    student = students( :mao )
    klass = klasses( :mao_class )
    attendance = attendances( :mao_attendance )
    assert_equal student.find_attendance_by_klass_id( klass ), attendance
    assert_equal student.is_canceled?( klass ), true
  end  
end

# == Schema Information
#
# Table name: students
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

