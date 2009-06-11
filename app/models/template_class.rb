class TemplateClass < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_time
  belongs_to :teacher
  belongs_to :classroom
  
  validates_presence_of :course_id, :course_time_id
  validates_format_of :day,
    :with => %r{\wday},
    :message => "must be chosen"
end
