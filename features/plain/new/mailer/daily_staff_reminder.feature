Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"
	
Scenario: Daily Staff Reminder at date
Given a klass: "1" exists with date: "2010-04-04"
	And a klass: "2" exists with date: "2010-04-04"
	And a teaching exists with klass: klass "1", teacher: user "aya", current: true, status_mask: 33, cost: "0"
	And a teaching exists with klass: klass "2", teacher: user "johan", current: true, status_mask: 33, cost: "1500"
When the system sends out the daily staff reminder to concerned teachers at "2010-04-04"
Then "aya@space.com" should receive 1 email
	And "johan@space.com" should receive no email

Scenario: Daily Staff Reminder for today
Given a klass exists with todays date
	And a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 33, cost: "0"
When the system sends out the daily staff reminder to concerned teachers
Then "aya@space.com" should receive 1 email