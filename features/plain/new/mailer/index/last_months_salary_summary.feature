Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg", cost: "1500", traveling_expenses: "450"
	And a course exists
	And a courses_teacher exists with course: that course, teacher: user "thomas"
	And a klass exists last month the 23rd with course: that course
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 9

@salary @last_month
Scenario: Choose Last Month's Salary Summary type for last month
Given a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then the "body" field should contain the last months salary teacher summary mail in english in "#last_month"
	And I should see "Thomas Osburg(1500y): 4950y" within "div#text_message"
	And I should see "Teaching sum: 3h=4500y" within "div#text_message"
	And I should see "Traveling expenses: 450y×1day=450y" within "div#text_message"
	And I should see "/23" within "div#text_message"
	And I should see no error flash message

@salary @english @japanese
Scenario Outline: Format in english and japanese
Given a klass exists with date: "2009-11-27", course: that course
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 9
	And a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas" of "December 24, 2009"
	And I select "Last Month's Salary Summary" as type in the select menu
	And I select "<language>" as language in the select menu
Then the "body" field should contain the last months salary teacher summary mail in <language> in "November 2009"
	And I should see "Thomas Osburg(1500<yen>): 4950<yen>" within "div#text_message"
	And I should see "3<hours>=4500<yen>" within "div#text_message"
	And I should see "450<yen>×1<days>=450<yen>" within "div#text_message"
	And I should see "11/27(<weekday>) 12:00～15:00=3<hours>" within "div#text_message"
	And I should see no error flash message
Examples:
|	language	|	yen	|	hours	| days	|	weekday	|
|	English		|	y		|	h			|	day		|	fri			|
|	Japanese	|	円		|	時間		|	日			|	金				|

@salary @arbitrarily_month
Scenario Outline: Choose Last Month's Salary Summary type for an arbitrarily month
Given a klass exists with date: "<class_date>", course: that course
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 9
	And a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas" of "<todays_date>"
	And I select "Last Month's Salary Summary" as type in the select menu
Then the "body" field should contain the last months salary teacher summary mail in english in "<salary_date>"
	And I should see "<confirm_date>" within "div#text_message"
Examples:
|	class_date 	|	todays_date				|	salary_date		|	confirm_date	|
|	2009-11-27	|	December 24, 2009	|	November 2009	|	11/27					|
|	2009-12-27	|	January 24, 2010	|	December 2009	|	12/27					|

@salary @no @traveling_expenses
Scenario: If a user has no traveling expenses, they should not be shown in the mail
Given a courses_teacher exists with course: that course, teacher: user "johan"
	And a teaching exists with klass: that klass, teacher: user "johan", status_mask: 9
	And a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "johan"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should not see "Traveling expenses" within "div#text_message"

@salary @subject
Scenario: Subject of the mail
Given a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then the "subject" field should contain "Last Month's Salary Summary"

@salary @bank_account
Scenario: Display the bank account details
Given a bank exists with name: "77:ans bank", branch: "main", account: "77777", signup_name: "Yes box!", user: user "thomas"
	And a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should see "77:ans bank  main  77777  Yes box!" within "div#text_message"

@salary @partly @bank_account
Scenario: Only the bank account details that are, should be shown
Given a bank exists with name: "77:ans bank", account: "77777", user: user "thomas"
	And a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should see "77:ans bank    77777  " within "div#text_message"

@salary @no @bank_account
Scenario: If the user has no bank account, it should not be shown
Given a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should not see "<%= @bank_name %>" within "div#text_message"
	And I should not see "<%= @bank_account %>" within "div#text_message"
	And I should not see "<%= @bank_branch %>" within "div#text_message"
	And I should not see "<%= @bank_signup_name %>" within "div#text_message"

@salary @untaught
Scenario: If a teacher has untaught classes, a flash message should be shown telling the admin that
Given a klass exists last month the 22rd with course: that course	
	And a teaching: "untaught" exists with klass: that klass, teacher: user "thomas", status_mask: 33
	And a user is logged in as "johan"	
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should see "Thomas Osburg has still unconfirmed classes." as error flash message