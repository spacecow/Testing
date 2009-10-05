class Klass < ActiveRecord::Base
  belongs_to :course
  belongs_to :teacher
  belongs_to :classroom
  has_many :attendances
  has_many :students, :through => :attendances

	versioned

	named_scope :course_name, lambda { |name| { :conditions=>["courses.name=?",name], :include=>:course }}  
  
  validates_presence_of :course_id, :date, :start_time, :end_time

	def date_and_time_interval
		date.strftime("%m")+"/"+date.strftime("%d")+": "+time_interval
	end

	# To be able to edit time with a textfield
	def end_time_string
		end_time.to_s(:time) if end_time
	end
	
	def end_time_string=(end_time_str)
		self.end_time = Time.parse( end_time_str ) if end_time_str != ""
	rescue ArgumentError
	end

	def equals( _date, _start_time, _end_time )
		date.strftime("%m") == _date.strftime("%m") &&
		date.strftime("%d") == _date.strftime("%d") &&
		start_time.to_s( :time ) == _start_time.to_s( :time ) &&
		end_time.to_s( :time ) == _end_time.to_s( :time )
	end

	def start_time_string
		start_time.to_s(:time) if start_time
	end
	
	def start_time_string=(start_time_str)
		self.start_time = Time.parse( start_time_str ) if start_time_str != ""
	rescue ArgumentError
	end
	#-----------------------------------------------
  
  def time_interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end
    
  def course_name
    course.name
  end
    
  def course_category
    course.category
  end
  
  def course_level
    course.level
  end   
  
	def stripped_time_interval
		start_time.to_s(:time).split(':').join+"_"+end_time.to_s(:time).split(':').join
	end

  def teacher_gender
    teacher.gender
  end

	def full_description
		course_name + (": ") + time_interval + ", " + date.strftime("%x")
	end
	
  def to_s
    course_name + (": ") + time_interval
  end
  
protected
	def validate_on_update
		if course_id != Klass.find( id ).course_id
      errors.add_to_base( I18n.translate('klasses.error.edit_courses_with_teacher') ) if !teacher_id.nil?
      errors.add_to_base( I18n.translate('klasses.error.edit_courses_with_students') ) if !students.empty?
		end
	end
end
