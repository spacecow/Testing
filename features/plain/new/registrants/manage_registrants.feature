Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin", language: "en", name_hurigana: "johan", email: "joh@n.se", occupation: "reg_e1", age: "age_10", tel: "080-1234-5678"
	And a user is logged in as "johan"
	And an event exist with title_en: "Christmas Party"
	And a registrant exists with event: that event, user: user "johan"

Scenario: List registrants
When I go to the registrants page
Then I should see "registrants" table
|	Occupation				|	Name					|	Name/Hurigana	|	Gender	|	Age		|	Nationality	|	Telephone number	|	Email Address	|	Note		|
| Exchange Student	|	Fake Fakeson	|	johan					|	Male		|	10's	|	Fakeland		|	080-1234-5678			|	joh@n.se			|					|
When I follow "Edit" within that registrant
Then I should be redirected to the edit page of that registrant