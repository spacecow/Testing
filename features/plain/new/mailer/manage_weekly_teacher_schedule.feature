Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu", email: "aya@space.com"
	
Scenario: Check format of mail of weekly teacher schedule
Given a course exists with name: "Ruby II"
Given a klass exists with date: "2010-04-05", course: that course, start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: that klass, teacher: user "johan"
When the system sends out schedule to concerned teachers from "2010-04-05"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "来週のシフトについて"
Then I should see "お疲れ様です。" in the email body	
	And I should see "梅津です。" in the email body	
	And I should see "4/5(Monday) - Ruby II - 12:00~13:00" in the email body
	And I should see "来週のシフトの確認をお願いします。" in the email body
	And I should see "以上、確認しましたのメール返信お願いします。" in the email body

Scenario: A teacher should only be informed about classes the coming week
Given a klass: "class04" exists with date: "2010-04-04"
	And a klass: "class05" exists with date: "2010-04-05"
	And a klass: "class10" exists with date: "2010-04-10"
	And a klass: "class11" exists with date: "2010-04-11"
	And a klass: "class12" exists with date: "2010-04-12"
	And a teaching exists with klass: klass "class04", teacher: user "johan"
	And a teaching exists with klass: klass "class05", teacher: user "johan"
	And a teaching exists with klass: klass "class10", teacher: user "johan"
	And a teaching exists with klass: klass "class11", teacher: user "johan"
	And a teaching exists with klass: klass "class12", teacher: user "johan"
When the system sends out schedule to concerned teachers from "2010-04-05"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "来週のシフトについて"
Then I should not see "4/4(Sunday)" in the email body
	And I should see "4/5(Monday)" in the email body
	And I should see "4/10(Saturday)" in the email body
	And I should see "4/11(Sunday)" in the email body
	And I should not see "4/12(Monday)" in the email body

Scenario: Concerned teachers should get an email each
Given a course: "ruby1" exists with name: "Ruby I"
	And a course: "ruby2" exists with name: "Ruby II"
	And a klass: "class05" exists with date: "2010-04-05", course: course "ruby1", start_time: "12:00", end_time: "13:00"
	And a klass: "class10" exists with date: "2010-04-10", course: course "ruby2", start_time: "14:00", end_time: "15:00"
	And a teaching exists with klass: klass "class05", teacher: user "johan"
	And a teaching exists with klass: klass "class10", teacher: user "aya"
When the system sends out schedule to concerned teachers from "2010-04-05"
Then "johan@space.com" should receive 1 email
	And "aya@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "来週のシフトについて"
Then I should see "4/5(Monday) - Ruby I - 12:00~13:00" in the email body
	And I should not see "4/10(Saturday)" in the email body
When "aya@space.com" opens the email with subject "来週のシフトについて"
Then I should not see "4/5(Monday)" in the email body
	And I should see "4/10(Saturday) - Ruby II - 14:00~15:00" in the email body