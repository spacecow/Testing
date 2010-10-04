class Student < ActiveRecord::Base
  has_and_belongs_to_many :courses
  #has_and_belongs_to_many :klasses
  belongs_to :person
  has_many :attendances
  has_many :klasses, :through=>:attendances
  
	named_scope :user, lambda { |user| { :conditions=>["people.user_name=?",user], :include=>:person }}  
  
  after_update :save_attendances

  def existing_attendance_attributes=(attendance_attributes)
    attendances.each do |attendance|
      attributes = attendance_attributes[ attendance.id.to_s ]
      if attributes
        attendance.attributes = attributes
      else
        #attendance.delete( attendance )
      end
    end
  end
  
  def save_attendances
    attendances.each do |a|
      a.save(false)
    end
  end

	def name
    "#{person.name}"
  end

  def to_s
    "#{person}"
  end
  
  def find_attendance_by_klass_id( klass )
    self.attendances.find_by_klass_id( klass )
  end
  
  def gender
    person.gender
  end

  def is_canceled?( klass )
    find_attendance_by_klass_id( klass ).cancel
  end
  
  def username
		person.user_name
	end  
end

# == Schema Information
#
# Table name: students
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

