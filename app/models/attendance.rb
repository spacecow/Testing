class Attendance < ActiveRecord::Base
  belongs_to :student, :class_name => 'User'
  belongs_to :klass

	named_scope :between_dates, lambda { |start,stop| {:conditions => ["klass_id = klasses.id and klasses.date >= ? and klasses.date < ?", start, stop], :include=>[:klass,:student]}}  
	named_scope :not_canceled, {:conditions => "attendances.cancel = false"}
  
  def start_date() klass.start_date end

  def student_id=(student)
    super(student) unless student==""
  end
  
  def student_gender
    student.gender
  end
  
  def student_name
    student.name
  end
  
  def date
  	klass.date
  end
  
  def time_interval
  	klass.time_interval
  end
  
  def class_attributes
  	attributes = []
  	attributes.push( "late" ) if late
		attributes << "cancel" if cancel
		attributes << "absent" if absent
  	"class=\"#{attributes.join(' ')}\""
  end
  
# Mail methods -----------------------

	def to_mail_date(language)
		klass.to_mail_date(language)
	end
	
	def to_time_interval_course( language,main_course )
		klass.to_time_interval_course( language,main_course )
	end
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

