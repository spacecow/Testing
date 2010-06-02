Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg", cost: "1500", traveling_expenses: "450"
	And a course exists
	And a courses_teacher exists with course: that course, teacher: user "thomas"
	And a klass exists last month the 23rd with course: that course
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 9
	And a user is logged in as "johan"	

@salary_last_month
Scenario: Choose Last Month's Salary Summary type for last month
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then the "body" field should contain the last months salary teacher summary mail in english in "#last_month"
	And I should see "Thomas Osburg(1500円): 4950円" within "div#text_message"
	And I should see "Total amount: 3時間=4500円" within "div#text_message"
	And I should see "Traveling expenses: 450円×1days=450円" within "div#text_message"
	And I should see "5/23" within "div#text_message"
	
@alary_arbitrarily_month
Scenario Outline: Choose Last Month's Salary Summary type for an arbitrarily month
	Given a klass exists with date: "<class_date>", course: that course
	And a teaching exists with klass: that klass, teacher: user "thomas", status_mask: 9
When I browse to the "Daily Mail" page for user "thomas" of "<todays_date>"
	And I select "Last Month's Salary Summary" as type in the select menu
Then the "body" field should contain the last months salary teacher summary mail in english in "<salary_date>"
	And I should see "Thomas Osburg(1500円): 4950円" within "div#text_message"	
	And I should see "Total amount: 3時間=4500円" within "div#text_message"
	And I should see "Traveling expenses: 450円×1days=450円" within "div#text_message"
	And I should see "<confirm_date>" within "div#text_message"
Examples:
|	class_date 	|	todays_date				|	salary_date		|	confirm_date	|
|	2009-11-27	|	December 24, 2009	|	November 2009	|	11/27					|
|	2009-12-27	|	January 24, 2010	|	December 2009	|	12/27					|

@no_traveling_expenses
Scenario: If a user has no traveling expenses, they should not be shown in the mail
Given a courses_teacher exists with course: that course, teacher: user "johan"
	And a teaching exists with klass: that klass, teacher: user "johan", status_mask: 9
When I browse to the "Daily Mail" page for user "johan"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should not see "Traveling expenses" within "div#text_message"

@subject
Scenario: Subject of the mail
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then the "subject" field should contain "Last Month's Salary Summary"

@bank_account
Scenario: Display the bank account details
Given a bank exists with name: "77:ans bank", branch: "main", account: "77777", signup_name: "Yes box!", user: user "thomas"
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should see "77:ans bank  main  77777  Yes box!" within "div#text_message"

@partly_bank_account
Scenario: Only the bank account details that are, should be shown
Given a bank exists with name: "77:ans bank", account: "77777", user: user "thomas"
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should see "77:ans bank    77777  " within "div#text_message"

@no_bank_account
Scenario: If the user has no bank account, it should not be shown
When I browse to the "Daily Mail" page for user "thomas"
	And I select "Last Month's Salary Summary" as type in the select menu
Then I should not see "<%= @bank_name %>" within "div#text_message"
	And I should not see "<%= @bank_account %>" within "div#text_message"
	And I should not see "<%= @bank_branch %>" within "div#text_message"
	And I should not see "<%= @bank_signup_name %>" within "div#text_message"


@pending
Scenario: If a teacher has untaught classes, a flash message should be shown