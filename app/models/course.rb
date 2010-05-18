class Course < ActiveRecord::Base
  has_and_belongs_to_many :students, :join_table => 'courses_students'
  has_many :template_classes
  has_many :klasses
  has_many :courses_teachers, :dependent => :destroy
  has_many :teachers, :through=>:courses_teachers
  has_many :schedules
    
  validates_presence_of :name, :level_ja, :level_en
  validates_uniqueness_of :name
  validates_inclusion_of :inactive, :in => [false, true]
  validate :format_of_name
  
  def category
    name.split[0]
  end
  
  def level
    name.split[1]
  end

	def level_to_s( language )
		if language == "ja"
			level_ja
		else
			level_en
		end
	end

  def to_s
    "#{name}"
  end
  
private
	def format_of_name
  	name.gsub!(/　/, " ") unless name.nil?
	end
end
