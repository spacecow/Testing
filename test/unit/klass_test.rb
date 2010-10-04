require File.dirname(__FILE__)+'/../test_helper'

class KlassTest < ActiveSupport::TestCase
  def test_find_same_klass
    date = Date.parse( "2009-06-02" )
    course = "入門 II"
    #find_same_klass( date, course )
  end
end
# == Schema Information
#
# Table name: klasses
#
#  id           :integer(4)      not null, primary key
#  course_id    :integer(4)
#  classroom_id :integer(4)
#  date         :datetime
#  start_time   :time
#  end_time     :time
#  title        :string(255)
#  description  :text
#  cancel       :boolean(1)      default(FALSE)
#  mail_sending :integer(1)      default(0)
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#  capacity     :string(255)
#

