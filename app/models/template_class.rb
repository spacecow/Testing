class TemplateClass < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_time
  belongs_to :teacher, :class_name => 'User'
  belongs_to :classroom
  
	named_scope :course_name, lambda { |name| { :conditions=>["courses.name=?",name], :include=>:course }}    
  
  validates_presence_of :course_id, :start_time, :end_time
  validates_format_of :day,
    :with => %r{\wday},
    :message => "must be chosen"
	validates_format_of :start_time,
		:with => /[1]{2}/,
		:message => "can't be blank"

  def course_category
    course.category
  end
  
  def course_level
    course.level
  end       
  
  def course_name
  	course.name
  end

	def day_and_time_interval
		day+": "+time_interval
	end

	def end_time_string
		end_time.to_s(:time) if end_time
	end
	
	def end_time_string=(end_time_str)
		self.end_time = Time.parse( end_time_str ) if end_time_str != ""
	rescue ArgumentError
	end

	def start_time_string
		start_time.to_s(:time) if start_time
	end
	
	def start_time_string=(start_time_str)
		self.start_time = Time.parse( start_time_str ) if start_time_str != ""
	rescue ArgumentError
	end

	def stripped_time_interval
		start_time.to_s(:time).split(':').join+"_"+end_time.to_s(:time).split(':').join
	end

	def teacher_gender
		teacher.gender
	end

  def time_interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end    
    
protected
	def validate_on_update
		if course_id != TemplateClass.find( id ).course_id
      p "Inside"
      errors.add_to_base( I18n.translate( 'template_klasses.error.edit_courses_with_teacher' )) unless teacher_id.nil?
      #errors.add_to_base( I18n.translate('klasses.error.edit_courses_with_students') ) if !students.empty?
		end
	end
end