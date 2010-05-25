class Teaching < ActiveRecord::Base
  belongs_to :teacher, :class_name => 'User'
  belongs_to :klass
  
  validates_presence_of :teacher_id, :klass_id
  validates_uniqueness_of :teacher_id, :scope => :klass_id
	validate :cost_must_be_a_number
  
  before_create :set_cost
  before_create :set_status_mask
  
  STATUS = %w[confirmed declined unconfirmed taught canceled untaught]
  
  named_scope :between_dates, lambda { |start,stop| {:conditions => ["klass_id = klasses.id and klasses.date >= ? and klasses.date < ?", start, stop], :include=>[:klass,:teacher]}}
  named_scope :teacher, lambda { |teacher_id| {:conditions => ["teacher_id = ?", teacher_id]}}
  named_scope :confirmed, {:conditions => "status_mask & #{2**STATUS.index('confirmed')} > 0"}# and status_mask & #{2**STATUS.index('canceled')} = 0"}
  named_scope :untaught, {:conditions => "status_mask & #{2**STATUS.index('untaught')} > 0"}
  named_scope :taught, {:conditions => "status_mask & #{2**STATUS.index('taught')} > 0"}
  named_scope :not_canceled, {:conditions => "status_mask & #{2**STATUS.index('canceled')} = 0"}
  named_scope :not_declined, {:conditions => "status_mask & #{2**STATUS.index('declined')} = 0"}
	named_scope :current, {:conditions => "current = true" }
	named_scope :staff, {:conditions => "teachings.cost = 0"}
	#named_scope :with, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }    
    
  def confirmed_symbol
  	if 		status? :confirmed;	"O"
  	elsif status? :declined;	"X"
		else;								  		"?"
		end
  end

  def taught_symbol
  	if 		status? :taught;  	"O"
  	elsif status? :canceled;  "X"
		else;								  		"?"
		end
  end

	def toggle_confirmation=( value )
		if value == "?";			self.confirm = "confirmed"
		elsif value == "O";		self.confirm = "declined"
		elsif value == "X";		self.confirm = ""
		end  
	end
	
	def toggle_taught=( value )
		if value == "?";			self.taught = "taught"
		elsif value == "O";		self.taught = "canceled"
		elsif value == "X";		self.taught = ""
		end
	end
	
	def toggle_taught_basic=( value )
		if value == "?";			self.taught = "taught"
		elsif value == "O";		self.taught = ""
		end
	end	
  
  def hours
  	( klass.duration/3600 ).round
  end
  
  def confirm=( value )
    if value.blank?;
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
    	reset_status :taught
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

	def confirm
		
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
	
	def to_time_interval_course(main_course, language)
		if klass.course.category == main_course
			course = klass.course.level_to_s( language )
		else
			course = klass.course.category + (language=='ja' ? '' : ' ') + klass.course.level_to_s( language )
		end
		"#{klass.japanese_time_interval}(#{course})"
	end
		
#------- Klass methods	
		
	def course; klass.course end
	def course_category; klass.course_category end
  def date; klass.date end
	def date_short; klass.date_short end
	def japanese_time_interval; klass.japanese_time_interval end
	def month; klass.month end
	def start_time; klass.start_time end
	def time_interval; klass.time_interval end
	
private

	def set_cost #unless it is created by factory through cucumber with another value
		if cost.nil?
			course_teacher = teacher.courses_teachers.select{|e| e.course_id==klass.course.id}.first unless teacher.nil?
			self.cost = course_teacher.cost.to_i * hours unless course_teacher.nil?
		end
	end
	
	def set_status_mask #unless it is created by factory through cucumber with another value
		add_status :unconfirmed if self.status_mask == 0
	end
	
  def cost_must_be_a_number
  	numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
  	numbers.each{|k,v| cost.gsub!(/#{k}/, "#{v}")} if !cost.nil? && cost.match(/[０-９]/)
  	errors.add(:cost, I18n.t('activerecord.errors.messages.not_a_number')) unless cost.nil? || cost.match(/^\d+$/) || errors.on(:cost)
  end	
end
