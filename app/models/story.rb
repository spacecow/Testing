class Story < ActiveRecord::Base
  attr_accessible :japanese, :english
end

# == Schema Information
#
# Table name: stories
#
#  id         :integer(4)      not null, primary key
#  japanese   :text
#  english    :text
#  created_at :datetime
#  updated_at :datetime
#

