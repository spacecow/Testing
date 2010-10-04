require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  it "should be valid" do
    Event.new.should be_valid
  end
end

# == Schema Information
#
# Table name: events
#
#  id                :integer(4)      not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  title_ja          :string(255)
#  description_ja    :text
#  title_en          :string(255)
#  description_en    :text
#  registrants_count :integer(4)      default(0)
#  place             :string(255)
#  start_date        :datetime
#  end_date          :datetime
#  pay_method        :string(255)
#  due_date          :datetime
#  cost              :string(255)
#

