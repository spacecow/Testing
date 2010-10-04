class Kunyomi < ActiveRecord::Base
	has_and_belongs_to_many :kanjis
	validates_uniqueness_of :reading
	validates_presence_of :reading
end

# == Schema Information
#
# Table name: kunyomis
#
#  id         :integer(4)      not null, primary key
#  reading    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

