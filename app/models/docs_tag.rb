class DocsTag < ActiveRecord::Base
	belongs_to :tags
	belongs_to :docs
end

# == Schema Information
#
# Table name: docs_tags
#
#  doc_id     :integer(4)
#  tag_id     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

