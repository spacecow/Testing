class Todo < ActiveRecord::Base
  belongs_to :user
	has_many :votes, :dependent => :destroy
	has_many :comments, :dependent => :destroy
  
  attr_accessible :title, :description, :user_id, :subjects
  validates_presence_of :title, :description, :user_id, :subjects
  
	SUBJECTS = %w[bug spelling feature]
	
  def subjects
    SUBJECTS.reject { |r| ((subjects_mask || 0) & 2**SUBJECTS.index(r)).zero? }
  end	
  
	def subjects=( subjects )
    self.subjects_mask = (subjects & SUBJECTS).map { |r| 2**SUBJECTS.index(r) }.sum
  end
  
  def points
  	votes.sum(:points)
  end
  
  def closed_message
  	if self.closed
  		return " - "+I18n.t(:closed).downcase
  	end
  	""
  end
end
