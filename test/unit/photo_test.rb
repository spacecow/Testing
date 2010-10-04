require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: photos
#
#  id                 :integer(4)      not null, primary key
#  gallery_id         :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer(4)
#  photo_updated_at   :datetime
#  caption_ja         :string(255)
#  caption_en         :string(255)
#  user_id            :integer(4)
#

