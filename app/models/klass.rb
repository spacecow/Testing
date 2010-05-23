class Klass < ActiveRecord::Base
  belongs_to :course, :counter_cache => true
  
  has_one :teaching, :dependent => :destroy
  has_one :teacher, :class_name => 'User', :through => :teaching
	accepts_nested_attributes_for :teaching

  has_many :teachings, :dependent => :destroy
  has_many :teachers, :class_name => 'User', :through => :teachings
	
  belongs_to :classroom
  
  has_many :attendances, :dependent => :destroy
  has_many :students, :through => :attendances

	versioned :only => :note

	named_scope :course_name, lambda { |name| { :conditions=>["courses.name=?",name], :include=>:course }}  
  
  validates_inclusion_of :cancel, :in => [false, true]
  validates_presence_of :course, :date
	validate :start_time_cannot_be_blank
	validate :end_time_cannot_be_blank  
	validates_numericality_of :capacity
	validate :capacity_cannot_be_zero

	after_update :save_teachings

	def capacity=( i )
		super( convert_japanese_numbers(i.to_s) )
	end

	def teaching
		return Teaching.new if self.teachings.empty?
		self.teachings.find_by_current( true )
	end

	def teaching_attributes=( hash )
		if hash[:id].nil?
			build_teaching( hash.merge( :current=>true ))
		elsif teachings.map(&:teacher_id).include?( hash[:teacher_id].to_i )
			teachings.map{|e| e.current = false }
			teachings[teachings.map(&:teacher_id).index( hash[:teacher_id].to_i )].current = true
		else
			teachings.map{|e| e.current = false }
			teachings.build( hash.merge( :current=>true ))
		end
	end
	
	def duration
		end_time - start_time
	end
	
	def save_teachings
		teachings.each do |t|
			t.save(false)
		end
	end

	def toggle_confirmation=( value );	teaching.toggle_confirmation = value	end
	def toggle_taught=( value );				teaching.toggle_taught = value				end

	def name;	month.to_s+"/"+day.to_s+"("+wday_to_s+") - "+course.to_s+" - "+time_interval	end
	def year;	date.year	end
	def month;	date.month	end
	def day;		date.day	end
	def wday;		date.wday-1	end
	def wday_to_s;	I18n.t( 'date.day_names' )[wday]	end
	def wday_abbr;	I18n.t( 'date.abbr_day_names' )[wday]	end	
	def date_short;	"#{month.to_s}/#{day.to_s}(#{wday_abbr})"		end
	def date_and_time_interval;	date.strftime("%m")+"/"+date.strftime("%d")+": "+time_interval	end

	# To be able to edit time with a textfield
	def end_time_string
		end_time.to_s(:time) if end_time
	end
	
	def end_time_string=( end_time_str )
		end_time_str = convert_time( end_time_str )
		if ok_time_format( end_time_str )
			self.end_time = Time.parse( end_time_str ) if end_time_str != ""
		end
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
	
	def start_time_string=( start_time_str )
		start_time_str = convert_time( start_time_str )
		if ok_time_format( start_time_str )
			self.start_time = Time.parse( start_time_str ) if start_time_str != ""
		end
	rescue ArgumentError
	end
	#-----------------------------------------------
  
  def time_interval
    start_time.to_s(:time)+"~"+end_time.to_s(:time)
  end
    
  def japanese_time_interval
    time_interval.gsub(/~/,'～')
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
    #course_name + (": ") + time_interval
    name
  end

	def self.generate_classes_for_reservation
		date = Date.current + 5.day
		date += 1.day while date.strftime("%a") != "Mon"
		generate_classes_for_reservation_from( date.strftime( "%Y-%m-%d" ))
	end

	def self.generate_classes_for_reservation_from( date )
		date = Time.zone.parse( date )
		#date = d + 5.day
		#date += 1.day while date.strftime("%a") != "Mon"
		while( date.strftime("%a") != "Sun" )
			unless Klass.find_by_date( date )
				TemplateClass.find_all_by_day( date.strftime("%a").downcase ).each do |t|
		  		t.create_class date
				end
			end
			date += 1.day
		end
	end
  
  def to_mail_date(language)
  	if language=='ja'
  		"#{month.to_s}/#{day.to_s}(#{%w(月 火 水 木 金 土 日)[wday]})"
		elsif language=='en'
			"#{month.to_s}/#{day.to_s}(#{%w(mon tue wed thu fri sat sun)[wday]})"
		end
  end
  
protected
	def validate_on_update
		if course_id != Klass.find( id ).course_id
      errors.add_to_base( I18n.translate('klasses.error.edit_courses_with_teacher') ) if !teacher_id.nil?
      errors.add_to_base( I18n.translate('klasses.error.edit_courses_with_students') ) if !students.empty?
		end
	end

private
	def start_time_cannot_be_blank
		errors.add :start_time_string, I18n.t('activerecord.errors.messages.blank') if start_time.nil?
	end
	def end_time_cannot_be_blank
		errors.add :end_time_string, I18n.t('activerecord.errors.messages.blank') if end_time.nil?
	end
	def capacity_cannot_be_zero
		errors.add :capacity, I18n.t('error.message.zero') if capacity == "0" unless errors.on( :capacity )
	end

	def ok_time_format( time_string )
		time_string.match(/^(\d)?\d:\d\d$/)
	end	
	def is_number( time_string )
		time_string.match(/^\d+$/)	
	end
  def convert_japanese_numbers( s )
		numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
  	numbers.each{|k,v| s.gsub!(/#{k}/, "#{v}")} if !s.nil? && s.match(/[０-９]/)
  	s
  end
	def convert_time( s )
		s = convert_japanese_numbers(s)
		s.gsub!(/^(\d?\d)$/,'\1:00')
		s.gsub!(/^(\d?\d)(\d\d)$/,'\1:\2')
		s
	end
end
