class Todo < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :title, :description, :user_id, :subjects
  validates_presence_of :title, :description, :user_id, :subjects
  
	SUBJECTS = %w[bug spelling]
	
  def subjects
    SUBJECTS.reject { |r| ((subjects_mask || 0) & 2**SUBJECTS.index(r)).zero? }
  end	
  
	def subjects=( subjects )
    self.subjects_mask = (subjects & SUBJECTS).map { |r| 2**SUBJECTS.index(r) }.sum
  end  
end
