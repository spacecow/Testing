@registrants

Scenario: A guest can make a simple registration
Given I go to the list of events
When I follow 'register'
Then I should not see 'role'
When I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'email' with "akira@docomo.ne.jp"
	And I fill in 'password' with "secret"
	And I fill in 'password_confirmation' with "secret"
	And I press 'create'
Then I should be redirected to the list of events
	And I should see 'users.notice.registration'

Scenario: Log in
Given a user exists with username: "kurosawa_akira", role: "registrant"
	And I go to the list of events
When I follow 'login.text'
	And I fill in 'user_name' with "kurosawa_akira"
	And I fill in 'password' with "secret"
	And I press 'login.button'
Then I should be redirected to the list of events
	And I should see 'login.notice.success'
	
Scenario: Register a user to an event
Given a user exists with username: "kurosawa_akira", role: "registrant"
	And a user is logged in as "kurosawa_akira	"
	And an event exists with title: "Christmas Event"
When I go to the list of events
	And I follow 'show'
	And I press 'register'
Then the "Email Address" field should contain "fake@fake.com"
When I select "一般(有償)" from 'occupation'
	And I fill in 'name' with "Kurosawa Akira"
	And I fill in 'name_hurigana' with "黒澤 明"
	And I choose "Female"
	And I select "10代" from 'age'
	And I fill in 'tel' with "080-1234-5678"
	And I press 'create'
Then I should see 'successfully'

Scenario: One cannot register to events without a user
Given an event exists with title: "Christmas Event"
When I go to the list of events
	And I follow 'show'
Then I should see 



















