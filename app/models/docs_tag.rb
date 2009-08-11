class DocsTag < ActiveRecord::Base
	belongs_to :tags
	belongs_to :docs
end
