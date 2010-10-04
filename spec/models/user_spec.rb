require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should be valid" do
    User.new.should be_valid
  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  username            :string(255)
#  email               :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  roles_mask          :integer(4)
#  role                :string(255)
#  occupation          :string(255)
#  name                :string(255)
#  name_hurigana       :string(255)
#  male                :boolean(1)
#  age                 :string(255)
#  tel                 :string(255)
#  nationality         :string(255)
#  language            :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#  invitation_id       :integer(4)
#  invitation_limit    :integer(4)
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  info_update         :boolean(1)      default(TRUE)
#  cost                :string(255)
#  traveling_expenses  :string(255)
#

