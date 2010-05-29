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
	validates_numericality_of :capacity
	validate :capacity_cannot_be_zero  
  
	def capacity=( i );		super( convert_japanese_numbers( i.to_s ))	end  
	def name=( s );				super( s.gsub( /　/, " " )) end
  
  def category;			name.split[0]		end
  def level;				name.split[1]		end
  def to_s;					"#{name}"  			end
  	
	def level_to_s( language )
		if language == "ja";	level_ja.to_s
		else;									level_en.to_s
		end
	end
  
private

	def capacity_cannot_be_zero
		errors.add :capacity, I18n.t('error.message.zero') if capacity == "0" unless errors.on( :capacity )
	end

  def convert_japanese_numbers( s )
		numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
  	numbers.each{|k,v| s.gsub!(/#{k}/, "#{v}")} if !s.nil? && s.match(/[０-９]/)
  	s
  end
  
end
