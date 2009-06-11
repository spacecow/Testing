module StudentsHelper
  def fields_for_attendance( attendance, &block )
    fields_for "student[existing_attendance_attributes][]", attendance, &block
  end
end
