Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en", name_hurigana: "johan", email: "joh@n.se"
	And a user is logged in as "johan"
	And an event exist with title_en: "Christmas Party"
	And I am registered for that event

Scenario: List registrants
When I go to the registrants page
Then I should see registrants table
|	Occupation				|	Name					|	Name/Hurigana	|	Gender	|	Age	|	Nationality	|	Telephone Number	|	Email Address	|	Note		|
| Exchange Student	|	Fake Fakeson	|	johan					|	Male		|	10	|	Fakeland		|	080-1234-5678			|	joh@n.se			|					|
When I follow "Edit" within that registrant
Then I should be redirected to the edit page of that registrant
  