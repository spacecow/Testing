Background:
Given a setting exists with name: "main"
	And a user: "staff" exist with username: "staff", role: "observer, teacher", language: "en", email: "staff@space.com", cost: "0"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", email: "johan@space.com", name: "Johan Sveholm", cost: "1500"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com", cost: "1400", traveling_expenses: "400"
	And a course exists with name: "Ruby I"
	And a courses_teacher exists with course: that course, teacher: user "johan"
	And a courses_teacher exists with course: that course, teacher: user "aya"
	And a klass exists last month the 23rd with course: that course, start_time: "10:00", end_time: "12:00"
	And a bank exists with name: "77:ans bank", branch: "main", account: "77777", signup_name: "Yes box!", user: user "johan"
	And a bank exists with name: "88:ans bank", account: "12345", user: user "aya"

@test_format
Scenario Outline: Check test format of mail of last month's salary
Given a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 9
When the system sends out the last month's salary summary to concerned teachers as <title> test
Then "<address>" should receive 1 email
When "<address>" opens the email with subject "#last_month_en's Salary, Please confirm"
Then I should see the last months salary teacher summary mail in english in the email body addressed to user "johan"
Examples:
|	title		|	address									|
|	yoyaku	|	Yoyaku@GAKUWARINET.com	|
|	johan		|	jsveholm@gmail.com			|

Scenario: Staff should not receive mail about salary
Given a teaching exists with klass: that klass, teacher: user "staff", current: true, status_mask: 9
When the system sends out the last month's salary summary to concerned teachers
Then "staff@space.com" should receive 0 email

@last_months_format_en
Scenario: Check the mail of last month's salary format in english
Given a teaching exists with klass: that klass, teacher: user "johan", current: true, status_mask: 9
When the system sends out the last month's salary summary to concerned teachers
Then "johan@space.com" should receive 1 email
When "johan@space.com" opens the email with subject "#last_month_en's Salary, Please confirm"
Then I should see the last months salary teacher summary mail in english in the email body
	And the email body should contain "#last_month's wages" in english
	And the email body should contain "#this_month 6th(#confirm_day)" in english
	And I should see "Johan Sveholm(1500y): 3000y" in the email body
	And I should not see "Traveling expenses" in the email body
	And I should see "Teaching sum: 2h=3000y" in the email body
	And I should see "77:ans bank  main  77777  Yes box!" in the email body

@last_months_format_ja
Scenario: Check the mail of last month's salary format in japanese
Given a teaching exists with klass: that klass, teacher: user "aya", current: true, status_mask: 9
When the system sends out the last month's salary summary to concerned teachers
Then "aya@space.com" should receive 1 email
When "aya@space.com" opens the email with subject "確認お願いします＿#last_month_ja月分賃金"
Then I should see the last months salary teacher summary mail in japanese in the email body
	And the email body should contain "#last_month月分の賃金" in japanese
	And the email body should contain "#this_month/6（#confirm_day）" in japanese
	And I should see "Aya Komatsu(1400円): 3200円" in the email body
	And I should see "交通: 400円×1日=400円" in the email body
	And I should see "講師合計: 2時間=2800円" in the email body
	And I should see "88:ans bank    12345  " in the email body
	
@pending
Scenario: Confirm day for japanese