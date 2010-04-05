class Teaching < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  belongs_to :klass
  
  validates_presence_of :teacher_id, :klass_id
  validates_uniqueness_of :teacher_id, :scope => :klass_id
  
  before_create :set_cost
  before_create :set_status_mask
  
  STATUS = %w[confirmed declined unconfirmed taught canceled untaught]
  
  named_scope :between_dates, lambda { |start,stop| {:conditions => "klass_id = klasses.id and klasses.date >= '#{start}' and klasses.date < '#{stop}'", :include=>:klass}} # and klasses.date >= #{start} and klasses.date < #{stop}", :include=>:klass} }
  named_scope :confirmed, {:conditions => "status_mask & #{2**STATUS.index('confirmed')} > 0 and status_mask & #{2**STATUS.index('canceled')} = 0"}
    
  def confirmed_symbol
  	if status? :confirmed
  		"O"
  	elsif status? :declined
  		"X"
		else
  		"?"
		end
  end

  def taught_symbol
  	if status? :taught
  		"O"
  	elsif status? :canceled
  		"X"
		else
  		"?"
		end
  end
  
  def confirm
    #status? :confirmed
  end
  
  def confirm=( value )
    if value.blank?
      set_status :unconfirmed
    elsif value=="confirmed"
      set_status :confirmed
      add_status :untaught
    elsif value=="declined"
      set_status :declined
    end
    save!
  end
  
  def taught=( value )
    if value.blank?
      reset_status :canceled
      add_status :untaught
    elsif value=="taught"
      reset_status :untaught
      add_status :taught
    elsif value=="canceled"
      reset_status :taught
      add_status :canceled
    end
    save!
  end
  

  def add_status( value )
    self.status_mask |= status_value( value )
  end

  def reset_status( value )
    self.status_mask &= 2**STATUS.size-1 - status_value( value )
  end
  
  def set_status( value )
		self.status_mask = status_value( value )  	
  end



  def status?( value )
    status.include?( value.to_s )
  end
  
  def status_value( value )
    index = STATUS.index( value.to_s )
    index.nil? ? 0 : 2**index
  end
  
  def status
    STATUS.reject {|r| ((status_mask || 0) & 2**STATUS.index(r)).zero? }
  end	
  
  def status=( value )
    self.status_mask = (value & STATUS).map {|r| 2**STATUS.index(r)}.sum
  end

	def to_s
		klass.to_s
	end
	
#------- Mail methods
	
	def to_mail_date(language)
		klass.to_mail_date(language)
	end
	
	def to_mail_time_interval(main_course, language)
		if language=='ja'
			if klass.course.category == main_course
				course = klass.course.level.gsub(/II/,"会話").gsub(/I/,"文法")
			else
				course = klass.course.name.gsub(/ II/,"会話").gsub(/ I/,"文法")
			end
		elsif language=='en'
			if klass.course.category == main_course
				course = klass.course.level.gsub(/II/,"conv.").gsub(/I/,"gram.")
			else
				course = klass.course.name.gsub(/ II/,"conv.").gsub(/ I/," gram.")
			end
		end			
		"#{klass.japanese_time_interval}(#{course})"
	end
		
#------- Klass methods	
	
	def time_interval
		klass.time_interval
	end
	
	def date
		klass.date
	end

	def course_category
    klass.course_category
  end
private

	def set_cost #unless it is created by factory through cucumber with another value
		if cost.nil?
			hour = ( klass.duration/3600 ).round
			course_teacher = teacher.courses_teachers.select{|e| e.course_id==klass.course.id}.first unless teacher.nil?
			self.cost = course_teacher.cost.to_i * hour unless course_teacher.nil?
		end
	end
	
	def set_status_mask #unless it is created by factory through cucumber with another value
		add_status :unconfirmed if self.status_mask == 0
	end
end
