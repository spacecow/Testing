Factory.define :attendance do |f|
end

Factory.define :classroom do |f|
end

Factory.define :comment do |f|
	f.comment "default comment"
end

Factory.define :course do |f|
	f.sequence(:name){|n| "name#{n} I" }
	f.level_ja "レベル"
	f.level_en "level"
	f.capacity "6"
end

Factory.define :course_time do |f|
end

Factory.define :courses_student do |f|
end

Factory.define :courses_teacher do |f|
	f.cost "1500"
end

Factory.define :event do |f|
	f.sequence(:title_en){|n| "Event #{n}" }
	f.sequence(:title_ja){|n| "イベント#{n}" }
	#f.start_date DateTime.new( Date.current.year, Date.current.month, Date.current.day )
	f.gallery {|gallery| gallery.association(:gallery)}
end

Factory.define :gallery do |f|
end

Factory.define :glossary do |f|
  f.kanji "言葉"
  f.hiragana "ことば"
end

Factory.define :invitation do |f|
	f.sequence(:recipient_email) { |n| "foo#{n}@example.com" }
	#f.recipient_email "foo"+rand(10000).to_s+"@example.com"
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
  f.capacity "6"
	f.date DateTime.new( Date.current.year, Date.current.month, Date.current.day )
	f.start_time Time.parse( "12:00" )
	f.end_time Time.parse( "15:00" )
	f.course {|course| course.association(:course)}
end

Factory.define :kunyomi do |f|
end

Factory.define :mail do |f|
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
  f.photo_file_name "sadako.jpg"
  f.photo_content_type "image/jpeg"
  f.photo_file_size 34284
  f.photo_updated_at Time.now
end

Factory.define :recipient do |f|
end

Factory.define :registrant do |f|
end

Factory.define :reset_password do |f|
end

Factory.define :scheduled_unit do |f|
end

Factory.define :setting do |f|
	f.version "0.11"
end

Factory.define :student do |f|
	f.association :person
end

#Factory.define :teacher do |f|
#	f.association :person
#end

Factory.define :teaching do |f|
	f.current true
end

Factory.define :todo do |f|
	f.title "default todo title"
	f.description "default todo description"
	#f.subjects ["bug", ""]
	f.user {|user| user.association(:user)}
end

Factory.define :template_class do |f|
  f.capacity "6"
  f.start_time Time.parse( "12:00" )
	f.end_time Time.parse( "15:00" )		
	f.day Date.current.strftime("%a").downcase
	f.course {|course| course.association(:course)}
end

Factory.define :unit do |f|
end

Factory.define :user do |f|
	f.sequence(:username) { |n| "username#{n}" }
	f.sequence(:email) { |n| "bar#{n}@example.com" }
	f.language "ja"
	f.role "registrant"
	f.male true
	f.name "Fake Fakeson"
	f.name_hurigana "フェイク フェイクソン"	
	f.nationality "Fakeland"
	f.password "secret"
	f.password_confirmation "secret"
	f.invitation_limit 5
	f.invitation {|invitation| invitation.association(:invitation)}
end

Factory.define :vote do |f|
	f.points 3
end

Factory.define :word do |f|
end