class Course < ActiveRecord::Base
  has_and_belongs_to_many :students, :join_table => 'courses_students'
  has_many :template_classes
  has_many :klasses
  has_many :teachings, :dependent => :destroy
  has_many :teachers, :through=>:teachings
  has_many :schedules
    
  validates_presence_of :name
  validates_uniqueness_of :name
  
  
  def category
    name.split[0]
  end
  
  def level
    name.split[1]
  end

  def to_s
    "#{name}"
  end
end
