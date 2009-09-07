Scenario: Course has to be selected in order to create a new unit
Given I have schedule "Shokyuu I"
	And I have teacher "johan_sveholm"
	And I am logged in as "johan_sveholm"
When I go to the list of units
	And I follow 'units.new' within "links"
	And I fill in 'unit' with "R1"
	And I fill in 'title' with "Nice to meet you"
	And I press 'create'
Then I should see "Schedule "'activerecord.errors.messages.blank'
When I select "Shokyuu I" from 'schedule'
	And I press 'create'
Then I should be redirected to the list of units	