class Teacher < ActiveRecord::Base
  belongs_to :person
  has_many :klasses
  has_many :teachings
  has_many :courses, :through=>:teachings

  def gender
    person.gender
  end

	def name
    "#{person.name}"
  end
  
  def to_s
    "#{person}"
  end
end
