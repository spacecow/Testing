@errors
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user is logged in as "johan"
	When I go to the new course page

Scenario: Japanese space should be turned into a European for name
When I fill in "Name" with "韓国語　初級"
	And I press "Create"
Then I should be redirected to the error courses page
	And the "Name" field should contain "韓国語 初級"