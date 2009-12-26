class Todo < ActiveRecord::Base
  belongs_to :user
	has_many :votes, :dependent => :destroy
	has_many :comments, :dependent => :destroy
  
  attr_accessible :title, :description, :user_id, :subjects
  validates_presence_of :title, :description, :user_id, :subjects

	named_scope :with_subject, lambda { |subject| {:conditions => "subjects_mask & #{2**SUBJECTS.index(subject.to_s)} > 0"} }

  STATUS_DROP = [
    ["open","open"],
    ["closed","closed"],
	]
	SUBJECTS_DROP = [
	  ["all","all"],
	  ["bug","bug"],
	  ["spelling","spelling"],
	  ["feature","feature"]
	]
  SORT_DROP = [
  	["points","points"],
  	["latest","created_at"],
  	["latest_comment", "latest_comment"]
	]
	ORDER_DROP = [
	  ["descending", "descending"],
	  ["ascending", "ascending"]
	]
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
  
  def latest_comment
		return DateTime.new if comments.empty?
		comments.sort_by(&:created_at).first.created_at
	end
  
  def closed_message
  	if self.closed
  		return " - "+I18n.t(:closed).downcase
  	end
  	""
  end
end
