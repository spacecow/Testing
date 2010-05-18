class Course < ActiveRecord::Base
  has_and_belongs_to_many :students, :join_table => 'courses_students'
  has_many :template_classes
  has_many :klasses
  has_many :courses_teachers, :dependent => :destroy
  has_many :teachers, :through=>:courses_teachers
  has_many :schedules
    
  validates_presence_of :name, :level_ja, :level_en, :capacity
  validates_uniqueness_of :name
  validates_inclusion_of :inactive, :in => [false, true]
  validate :capacity_must_be_a_number
  
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
  def capacity_must_be_a_number
  	numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
  	numbers.each{|k,v| capacity.gsub!(/#{k}/, "#{v}")} if !capacity.nil? && capacity.match(/[０-９]/)
  	errors.add(:capacity, I18n.t('activerecord.errors.messages.not_a_number')) unless capacity.match(/^\d+$/) || errors.on(:capacity)
	end
end
