class Teacher < ActiveRecord::Base
  belongs_to :person
  has_many :klasses
  has_many :teachings
  has_many :courses, :through=>:teachings

	named_scope :user, lambda { |user| { :conditions=>["people.user_name=?",user], :include=>:person }}

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

# == Schema Information
#
# Table name: teachers
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

