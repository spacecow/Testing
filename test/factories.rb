Factory.define :attendance do |f|
end

Factory.define :classroom do |f|
end

Factory.define :course do |f|
end

Factory.define :course_time do |f|
end

Factory.define :courses_student do |f|
end

Factory.define :event do |f|
	f.title_en "Event 1"
	f.title_ja "イベント１"
	f.date DateTime.new( Date.current.year, Date.current.month, Date.current.day )
	f.gallery {|gallery| gallery.association(:gallery)}
end

Factory.define :gallery do |f|
end

Factory.define :glossary do |f|
  f.kanji "言葉"
  f.hiragana "ことば"
end

Factory.define :invitation do |f|
end

Factory.define :kanji do |f|
end

Factory.define :kanjis_kunyomis do |f|
end

Factory.define :kanjis_meanings do |f|
end

Factory.define :kanjis_onyomis do |f|
end

Factory.define :klass do |f|
	f.date DateTime.new( Date.current.year, Date.current.month, Date.current.day )
	f.start_time Time.parse( "12:00" )
	f.end_time Time.parse( "15:00" )
end

Factory.define :kunyomi do |f|
end

Factory.define :meaning do |f|
end

Factory.define :onyomi do |f|
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

Factory.define :photo do |f|
  f.photo_content_type "image/jpeg"
  f.photo_file_size 37423
end

Factory.define :registrant do |f|
end

Factory.define :scheduled_unit do |f|
end

Factory.define :setting do |f|
end

Factory.define :student do |f|
	f.association :person
end

Factory.define :teacher do |f|
	f.association :person
end

Factory.define :teaching do |f|
end

Factory.define :template_class do |f|
	f.start_time Time.parse( "12:00" )
	f.end_time Time.parse( "15:00" )		
	f.day Date.current.strftime("%A")
end

Factory.define :unit do |f|
end

Factory.define :user do |f|
	f.username "username"
	f.email "fake@fake.com"
	f.language "ja"
	f.role "registrant"
	f.male true
	f.name "Fake Fakeson"
	f.name_hurigana "フェイク フェイクソン"	
	f.nationality "Fakeland"
	f.password "secret"
	f.password_confirmation "secret"
	f.invitation_limit 5
end