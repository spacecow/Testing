class Gallery < ActiveRecord::Base
  attr_accessible :description
  belongs_to :event
  has_many :photos, :dependent => :destroy
end

# == Schema Information
#
# Table name: galleries
#
#  id          :integer(4)      not null, primary key
#  event_id    :integer(4)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

