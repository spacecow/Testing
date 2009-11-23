class Registrant < ActiveRecord::Base
	belongs_to :event

  attr_accessible :occupation, :name, :name_hurigana, :event_id, :male, :age, :tel, :email, :note
  
  validates_presence_of :occupation, :name, :name_hurigana, :event_id, :male, :age, :tel, :email
  
  OCCUPATIONS = [
  	"一般(有償)",
  	"一般(無償/中学生以下)",
  	"NPO法人学割net会員(無償)",
  	"まふまふ語学講座生徒(有償/割引)",
  	"TPチケット使用(無償/一般)",
  	"TPチケット使用(無償/受講生)"
	]
	
	AGE = %w( 中学生以下 10代 20代 30代 40代 50代 60代以上 )
end
