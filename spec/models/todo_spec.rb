require File.dirname(__FILE__) + '/../spec_helper'

describe Todo do
  it "should be valid" do
    Todo.new.should be_valid
  end
end

# == Schema Information
#
# Table name: todos
#
#  id            :integer(4)      not null, primary key
#  title         :string(255)
#  description   :text
#  user_id       :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#  subjects_mask :integer(4)
#  closed        :boolean(1)      default(FALSE)
#

