@registrants
Scenario: A guest cannot register
Given I go to the list of events
Then I should not see 'register'

Scenario: Log in
Given I go to the list of events
	And I follow 'login.text'
	