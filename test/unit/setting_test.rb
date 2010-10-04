require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: settings
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(255)
#  people_per_page       :integer(4)
#  units_per_schedule    :integer(4)
#  language              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  events_description_en :text
#  events_description_ja :text
#  version               :string(255)
#  todos_description_en  :text
#  todos_description_ja  :text
#  subdomain             :string(255)
#

