class Todo < ActiveRecord::Base
  attr_accessible :title, :description, :votes, :user_id
end
