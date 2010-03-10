class TemplateClass < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_time
  belongs_to :teacher, :class_name => 'User'
  belongs_to :classroom
  
	named_scope :course_name, lambda { |name| { :conditions=>["courses.name=?",name], :include=>:course }}    
  
  validates_presence_of :course, :day
  validates_inclusion_of :inactive, :in => [false, true]
	validate :start_time_cannot_be_blank
	validate :end_time_cannot_be_blank
	validate_on_update :course_cannot_be_changed
	validates_numericality_of :capacity
	validate :capacity_cannot_be_zero	
	
	DAYS = %w( mon tue wed thu fri sat sun )

  def course_category
    course.category
  end
  
  def course_level
    course.level
  end       
  
  def course_name
  	course.name
  end

	def day_to_s
		I18n.t('date.day_names')[ DAYS.index( day ) ]
	end
	def day_and_time_interval
		day+": "+time_interval
	end

	# To be able to edit time with a textfield
	def end_time_string
		end_time.to_s(:time) if end_time
	end
	
	def end_time_string=( end_time_str )
		if( end_time_str.match(/^(\d)?\d$/))
			end_time_str += ":00"	
		end
		if ok_time_format( end_time_str )
			self.end_time = Time.parse( end_time_str ) if end_time_str != ""
		end
	rescue ArgumentError
	end

	def start_time_string
		start_time.to_s(:time) if start_time
	end
	
	def start_time_string=( start_time_str )
		if( start_time_str.match(/^(\d)?\d$/))
			start_time_str += ":00"	
		end
		if ok_time_format( start_time_str )
			self.start_time = Time.parse( start_time_str ) if start_time_str != ""
		end
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
  
  def create_class( date )
		Klass.create!(
			:course_id=>self.course_id,
			#:teacher_id=>self.teacher_id,
			:classroom_id=>self.classroom_id,
			:capacity=>self.capacity,      
			:date=>date.strftime( "%Y-%m-%d" ),
			:start_time=>self.start_time,
			:end_time=>self.end_time,
			:title=>self.title,
			:description=>self.description,
			:cancel=>self.inactive,
			:mail_sending=>self.mail_sending,
			:note=>self.note
  	).date
  end
  
private
	def capacity_cannot_be_zero
		errors.add :capacity, I18n.t('error.message.zero') if capacity == 0 unless errors.on( :capacity )
	end
	
	def start_time_cannot_be_blank
		errors.add :start_time_string, I18n.t('activerecord.errors.messages.blank') if start_time.nil?
	end
	
	def end_time_cannot_be_blank
		errors.add :end_time_string, I18n.t('activerecord.errors.messages.blank') if end_time.nil?
	end

	def ok_time_format( time_string )
		time_string.match(/^(\d)?\d:\d\d$/)
	end	
  
protected
	def validate_on_update
		if course_id != TemplateClass.find( id ).course_id
      p "Inside"
      errors.add_to_base( I18n.translate( 'template_klasses.error.edit_courses_with_teacher' )) unless teacher_id.nil?
      #errors.add_to_base( I18n.translate('klasses.error.edit_courses_with_students') ) if !students.empty?
		end
	end
		
	def course_cannot_be_changed
		errors.add :course, "cannot be changed" if TemplateClass.find( id ).course != course	
	end
end