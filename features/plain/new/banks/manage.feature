Background:
Given a setting exists with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en"
	And a user is logged in as "johan"

Scenario: Create a bank account
When I go to the edit page of user "johan"
	And I fill in "Bank Name" with "77:ans bank"
	And I fill in "Branch" with "Main"
	And I fill in "Account" with "77777"
	And I fill in "Signup Name" with "Yes box!"
	And I press "Update"
Then a bank should exist with name: "77:ans bank", branch: "main", account: "77777", signup_name: "Yes box!", user: user "johan"

Scenario: If a bank acoount already is created, an extra should not be
Given a bank exists with name: "77:ans bank", branch: "main", account: "77777", signup_name: "Yes box!", user: user "johan"
When I go to the edit page of user "johan"
	And I press "Update"
Then 1 banks should exist
