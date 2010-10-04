class Doc < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  def to_s
    title
  end
end

# == Schema Information
#
# Table name: docs
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  url        :string(255)
#  contents   :text
#  created_at :datetime
#  updated_at :datetime
#

