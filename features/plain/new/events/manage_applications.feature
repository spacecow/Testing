@manage_applications
Background:
Given a setting exists with name: "main"

Scenario: Register a user to an event
Given a user: "kurosawa" exists with username: "kurosawa_akira", role: "registrant", language: "en"
	And a user is logged in as "kurosawa_akira"
	And an event: "christmas" exists with title_en: "Christmas Party"
When I go to the events page
	And I follow 'show'
Then I should see "You have not applied for this event yet!"
	And I press 'apply'
Then "" should not be selected in "user_occupation"
	And "" should not be selected in "user_age"
When I press 'apply'
Then I should see "Occupation*Exchange StudentALTetccan't be blank"                
	And I should see "Age*Under Junior High School10's20's30's40's50'sOver 60can't be blank"
	And I should see "Telephone number*can't be blank"
When I select "Exchange Student" from 'occupation'
	And I select "20's" from 'age'
	And I fill in 'tel' with "080-1234-5678"
	And I press "Apply"
Then I should see "Successfully registered for Christmas Party." within "div#notice"
	Then a registrant should exist with event: event "christmas", user: user "kurosawa"
	And a user should exist with occupation: "reg_e1", age: "age_20", tel: "080-1234-5678"
When I go to the show page of that event
Then I should see "You have already applied for this event."