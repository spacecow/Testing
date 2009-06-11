class Person < ActiveRecord::Base
  has_one :teacher
  has_one :student
  
  attr_accessor :password

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
    user = self.find_by_user_name( user_name )
    if user
      expected_password = encrypted_password( password, user.salt )
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def name
    if first_name == "-----"
      "----------"
    else
      "#{family_name} #{first_name}"
    end
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
