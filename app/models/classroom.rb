class Classroom < ActiveRecord::Base
  has_many :klasses
  has_many :template_classes
  
  def to_s
    "#{name}"
  end
end
