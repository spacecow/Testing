require File.dirname(__FILE__) + '/../spec_helper'

describe Word do
  it "should be valid" do
    Word.new.should be_valid
  end
end

# == Schema Information
#
# Table name: words
#
#  id       :integer(4)      not null, primary key
#  japanese :string(255)
#  reading  :string(255)
#  meaning  :string(255)
#

