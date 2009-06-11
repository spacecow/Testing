class Doc < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  def to_s
    title
  end
end
