class Registrant < ActiveRecord::Base
	belongs_to :event, :counter_cache => true
	belongs_to :user

#  attr_accessible :occupation, :name, :name_hurigana, :event_id, :male, :age, :tel, :email, :note
  
#  validates_presence_of :occupation, :name, :name_hurigana, :event_id, :age, :tel, :email
#  validates_inclusion_of :male, :in => [false, true]
  
  OCCUPATIONS_JA = [
  	["一般(有償)","reg_j1"],
  	["一般(無償/中学生以下)","reg_j2"],
  	["NPO法人学割net会員(無償)","reg_j3"],
  	["まふまふ語学講座生徒(有償/割引)","reg_j4"],
  	["TPチケット使用(無償/一般)","reg_j5"],
  	["TPチケット使用(無償/受講生)","reg_j6"]
	]
  OCCUPATIONS_EN = [
  	["Exchange Student","reg_e1"],
  	["ALT","reg_e2"],
  	["etc","reg_e3"]
	]	
	
	AGE_JA = [
	  ["中学生以下","age_jr"],
	  ["10代","age_10"],
	  ["20代","age_20"],
	  ["30代","age_30"],
	  ["40代","age_40"],
	  ["50代","age_50"],
	  ["60代以上","age_60"]
	]
	AGE_EN = [
	  ["Under Junior High School","age_jr"],
	  ["10's","age_10"],
	  ["20's","age_20"],
	  ["30's","age_30"],
	  ["40's","age_40"],
	  ["50's","age_50"],
	  ["Over 60","age_60"]
	]
end

# == Schema Information
#
# Table name: registrants
#
#  id         :integer(4)      not null, primary key
#  event_id   :integer(4)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)
#

