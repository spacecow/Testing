require File.dirname(__FILE__) + '/../spec_helper'

describe Glossary do
  it "should be valid" do
    Glossary.new.should be_valid
  end
end


# == Schema Information
#
# Table name: glossaries
#
#  id         :integer(4)      not null, primary key
#  japanese   :string(255)
#  english    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  state      :integer(4)      default(0)
#  word_id    :integer(4)
#

