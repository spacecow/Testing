class Teaching < ActiveRecord::Base
  belongs_to :teacher, :class_name=>'User'
  belongs_to :klass
end
