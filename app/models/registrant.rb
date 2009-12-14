class Registrant < ActiveRecord::Base
	belongs_to :event, :counter_cache => true
	belongs_to :user

#  attr_accessible :occupation, :name, :name_hurigana, :event_id, :male, :age, :tel, :email, :note
  
#  validates_presence_of :occupation, :name, :name_hurigana, :event_id, :age, :tel, :email
#  validates_inclusion_of :male, :in => [false, true]
  
  OCCUPATIONS_JA = [
  	"一般(有償)",
  	"一般(無償/中学生以下)",
  	"NPO法人学割net会員(無償)",
  	"まふまふ語学講座生徒(有償/割引)",
  	"TPチケット使用(無償/一般)",
  	"TPチケット使用(無償/受講生)"
	]
  OCCUPATIONS_EN = [
  	"Exchange Student",
  	"ALT",
  	"etc"
	]	
	
	
	AGE_JA = [["中学生以下","Jr-"],["10代","10"],["20代","20"],["30代","30"],["40代","40"],["50代","50"],["60代以上","60+"]]
	AGE_EN = [["Under Junior High School","Jr-"],["10's","10"],["20's","20"],["30's","30"],["40's","40"],["50's","50"],["Over 60","60+"]]
	
end
