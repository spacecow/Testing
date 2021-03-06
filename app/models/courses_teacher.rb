class CoursesTeacher < ActiveRecord::Base
  belongs_to :teacher, :class_name=>'User'
  belongs_to :course

	validate :cost_must_be_a_number
	validates_presence_of :teacher_id, :course_id
  validates_uniqueness_of :teacher_id, :scope => :course_id
  
  before_save :set_cost
  
private
	def set_cost #unless it is created by factory through cucumber with another value
		self.cost = teacher.cost if cost.nil?
	end

	def cost_must_be_a_number
		unless cost.nil?
			numbers = {"０"=>"0", "１"=>"1", "２"=>"2", "３"=>"3", "４"=>"4", "５"=>"5", "６"=>"6", "７"=>"7", "８"=>"8", "９"=>"9"}
			numbers.each{|k,v| cost.gsub!(/#{k}/, "#{v}")} if cost.match(/[０-９]/)
			errors.add(:cost, I18n.t('activerecord.errors.messages.not_a_number')) unless cost.match(/^\d+$/)
		end
	end
end

# == Schema Information
#
# Table name: courses_teachers
#
#  id         :integer(4)      not null, primary key
#  teacher_id :integer(4)
#  course_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  chosen     :boolean(1)      default(FALSE)
#  cost       :string(255)
#

