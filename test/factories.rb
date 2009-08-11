Factory.define :student do |f|
	f.association :person
end

Factory.define :teacher do |f|
	f.association :person
end

Factory.define :person do |f|
  f.mail_address_mobile "fake@softbank.ne.jp"
  f.gender 1
  f.first_name "fake"
  f.family_name "fakeson"
  f.first_name_kana "フェイク"
  f.family_name_kana "フェイクソン"
  f.language "en"
end

Factory.define :template_class do |f|
	f.start_time Time.parse( "12:00" )
	f.end_time Time.parse( "15:00" )		
	f.day Date.current.strftime("%A")
end

Factory.define :klass do |f|
	f.date DateTime.new( Date.current.year, Date.current.month, Date.current.day )
	f.start_time Time.parse( "12:00" )
	f.end_time Time.parse( "15:00" )
end

Factory.define :course_time do |f|
end

Factory.define :attendance do |f|
end

Factory.define :classroom do |f|
end

Factory.define :courses_student do |f|
end

Factory.define :course do |f|
end

Factory.define :teaching do |f|
end