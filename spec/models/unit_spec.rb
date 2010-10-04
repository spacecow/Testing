require File.dirname(__FILE__) + '/../spec_helper'

describe Unit do
  it "should be valid" do
    Unit.new.should be_valid
  end
end

# == Schema Information
#
# Table name: units
#
#  id           :integer(4)      not null, primary key
#  unit         :string(255)
#  schedule_id  :integer(4)
#  title        :string(255)
#  page         :string(255)
#  grammar_unit :string(255)
#  description  :text
#  note         :text
#  created_at   :datetime
#  updated_at   :datetime
#

