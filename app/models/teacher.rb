class Teacher < ActiveRecord::Base
  belongs_to :person
  has_many :klasses

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
