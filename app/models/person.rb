class Person < ActiveRecord::Base
  has_one :teacher
  has_one :student
  
  validates_uniqueness_of :user_name
  validates_presence_of :family_name, :first_name, :family_name_kana, :first_name_kana, :gender, :mail_address_mobile

	def linked_student
	  self.student
	end
	
	def linked_student=(bajs)
	  self.student ||= Student.new
	end

	def linked_teacher
	  self.teacher
	end
	
	def linked_teacher=(bajs)
	  self.teacher ||= Teacher.new
	end

  def password
    @password
  end

  def password=( pwd )
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password =
      Person.encrypted_password( self.password, self.salt )
  end

  def self.authenticate( user_name, password )
    user = self.find_by_user_name( user_name, :include => [ :teacher, :student ])
    if user
      expected_password = encrypted_password( password, user.salt )
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def name
  	if first_name == "-----" && family_name == "-----"
      "----------"
	elsif family_name == "Cancel"
	  "Cancel"
	elsif family_name == "Delete"
      "Delete"
    else
      "#{family_name} #{first_name}"
    end
  end 
  
  def name_hurigana
		"#{family_name_kana} #{first_name_kana}"
  end

  def to_s
    "#{family_name} #{first_name}"
  end
  
private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password( password, salt )
    string_to_hash = password + "cobra" + salt
    Digest::SHA1.hexdigest( string_to_hash )
  end  
end

# == Schema Information
#
# Table name: people
#
#  id                  :integer(4)      not null, primary key
#  user_name           :string(255)
#  family_name         :string(255)
#  first_name          :string(255)
#  family_name_kana    :string(255)
#  first_name_kana     :string(255)
#  gender              :integer(1)
#  address1            :string(255)
#  address2            :string(255)
#  home_phone          :string(10)
#  mobile_phone        :string(11)
#  mail_address_mobile :string(255)
#  mail_address_pc     :string(255)
#  ritei               :boolean(1)
#  last_login          :datetime
#  note                :text
#  created_at          :datetime
#  updated_at          :datetime
#  inactive            :boolean(1)
#  status              :integer(2)
#  tostring            :string(255)
#  hashed_password     :string(255)
#  salt                :string(255)
#  check               :string(255)
#  language            :string(255)     default("ja")
#

