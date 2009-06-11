class Course < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_many :template_classes
  has_many :klasses
  
  validates_presence_of :name
  
  
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
