@scheduled_units
Background:
Given I have course "Ruby I"
	And the following template class records
	|	course 	|	day 		|	start_time	|	end_time	|
	|	Ruby I	|	Monday	|	11:15				|	12:15			|
	|	Ruby I	|	Monday	|	11:15				|	12:15			|
	|	Ruby I	|	Monday	|	13:00				|	15:00			|
	|	Ruby I	|	Tuesday	|	13:00				|	15:00			|
	And I have schedule "Ruby I"
	And I have teacher "johan_sveholm"
	And I am logged in as "johan_sveholm"
	And I go to the list of schedules

Scenario: Listing schedules
Then I should see "Ruby I" within "list"

Scenario: Listing units
	When I follow 'edit' for schedule "Ruby I"
	Then I should see "9/14 Mon 11:15~12:15"