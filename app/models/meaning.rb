class Meaning < ActiveRecord::Base
	has_and_belongs_to_many :kanjis
	validates_uniqueness_of :title
	validates_presence_of :title
end

# == Schema Information
#
# Table name: meanings
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

