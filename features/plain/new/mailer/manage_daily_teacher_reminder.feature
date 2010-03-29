Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu", email: "aya@space.com"
	
Scenario: Check format of mail of daily teacher reminder
Given a course exists with name: "Ruby II"
Given a klass exists with date: "2010-04-05", course: that course, start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: that klass, teacher: user "johan"
When the system sends out the daily teacher reminder for "2010-04-05"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "reminder"
Then I should see "Hello!" in the email body
	And I should see "I just want to let you know you have class today." in the email body
	And I should see "4/5(Monday) - Ruby II - 12:00~13:00" in the email body
	And I should see "Please come to class 10mins before class start!" in the email body
	And I should see "If you are going to be late ,please call me~!" in the email body
	And I should see "それでは本日もよろしくお願いいたします！" in the email body
	And I should see "FROM AYA" in the email body

Scenario: A teacher should only be informed about todays classes
Given a klass: "class04" exists with date: "2010-04-04"
	And a klass: "class05" exists with date: "2010-04-05"
	And a klass: "class06" exists with date: "2010-04-06"
	And a teaching exists with klass: klass "class04", teacher: user "johan"
	And a teaching exists with klass: klass "class05", teacher: user "johan"
	And a teaching exists with klass: klass "class06", teacher: user "johan"
When the system sends out the daily teacher reminder for "2010-04-05"
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "reminder"
Then I should not see "4/4(Sunday)" in the email body
	And I should see "4/5(Monday)" in the email body
	And I should not see "4/6(Tuesday)" in the email body
	
Scenario: Concerned teachers should get an email each
Given a course: "ruby1" exists with name: "Ruby I"
	And a course: "ruby2" exists with name: "Ruby II"
	And a klass: "johan" exists with date: "2010-04-05", course: course "ruby1", start_time: "12:00", end_time: "13:00"
	And a klass: "aya" exists with date: "2010-04-05", course: course "ruby2", start_time: "14:00", end_time: "15:00"
	And a teaching exists with klass: klass "johan", teacher: user "johan"
	And a teaching exists with klass: klass "aya", teacher: user "aya"
When the system sends out the daily teacher reminder for "2010-04-05"
Then "johan@space.com" should receive 1 email
	And "aya@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "reminder"
Then I should see "4/5(Monday) - Ruby I - 12:00~13:00" in the email body
	And I should not see "4/5(Monday) - Ruby II - 14:00~15:00" in the email body
When "aya@space.com" opens the email with subject "reminder"
Then I should not see "4/5(Monday) - Ruby I - 12:00~13:00" in the email body
	And I should see "4/5(Monday) - Ruby II - 14:00~15:00" in the email body

Scenario: If a teaching is not current it should not appear (NOT IMPLEMENTED)
Given not implemented