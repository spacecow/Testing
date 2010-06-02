Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", email: "johan@space.com", name: "Johan Sveholm", cost: "1500"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"
	And a course exists with name: "Ruby I"

@last_months_format_en
Scenario: Check the mail of last month's salary format in english
Given a klass exists last month the 23rd with course: that course, start_time: "10:00", end_time: "12:00"
	And a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 9
When the system sends out the last month's salary summary to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "#last_month's Salary Summary"
Then I should see the last months salary teacher summary mail in english in the email body
	And I should see "#last_months's wages" in the email body
	And I should see "#this_month 6th(#day_6)"
	And I should see "Johan Sveholm(1500円): 3000円"
	And I should see "Total amount: 2時間=3000円"

@last_months_format_ha
Scenario: Check the mail of last month's salary format in japanese
Given a klass exists last month the 23rd
	And a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 9
When the system sends out the last months salary teacher summary to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "#last_month's Salary"
Then I should see the last month's salary summary mail in japanese in the email body
