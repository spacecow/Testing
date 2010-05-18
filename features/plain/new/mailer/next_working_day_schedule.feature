Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"
	
Scenario Outline: Next working day schedule
Given a klass exists with date: "2010-04-04"
	And a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 33
When the system sends out next working day's teacher reminder to concerned teachers at "<date>"
Then "aya@space.com" should receive 1 email
Examples
|	date				|
|	2010-04-03	|
|	2010-04-02	|

Scenario: Next working day schedule
Given a klass exists with tomorrows date
	And a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 33
When the system sends out next working day's teacher reminder to concerned teachers
Then "aya@space.com" should receive 1 email