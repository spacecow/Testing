class Classroom < ActiveRecord::Base
  has_many :klasses
  has_many :template_classes
  
  def to_s
    "#{name}"
  end
end

# == Schema Information
#
# Table name: classrooms
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  address     :string(255)
#  description :text
#  inactive    :boolean(1)      default(FALSE)
#  note        :text
#  created_at  :datetime
#  updated_at  :datetime
#

