class Gallery < ActiveRecord::Base
  attr_accessible :description
  belongs_to :event
  has_many :photos, :dependent => :destroy
end
