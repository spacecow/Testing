@scheduled_unit
Background:
Given I have course "Ruby I"
	And the following template class records
	|	course 	|	day 		|	start_time	|	end_time	|
	|	Ruby I	|	Monday	|	11:15				|	12:15			|
	|	Ruby I	|	Monday	|	11:15				|	12:15			|
	|	Ruby I	|	Monday	|	13:00				|	15:00			|
	|	Ruby I	|	Monday	|	15:50				|	17:50			|	
	|	Ruby I	|	Tuesday	|	13:00				|	15:00			|
	And I have schedule "Ruby I"
	And the following unit records
	|	id	|	unit	|	schedule	| title										|
	|	1		|	H1		|	Ruby I		|	Nice to meet you				|
	|	2		|	H2		|	Ruby I		|	Family and Feelings			|
	|	3		|	H3		|	Ruby I		|	In the neiborhood				|
	|	4		|	H4		|	Ruby I		|	My style, your style		|
	|	5		|	H5		|	Ruby I		|	What's your schedule		|
	|	6		|	H6		|	Ruby I		|	Review 1								|
	|	7		|	H7		|	Ruby I		|	Past times, fast times	|
	|	8		|	H8		|	Ruby I		|	The things we eat				|
	|	9		|	H9		|	Ruby I		|	Getting away     				|
	|	10	|	H10		|	Ruby I		|	TV, radio and the net		|	
	And I have teacher "johan_sveholm"
	And I am logged in as "johan_sveholm"

Scenario: Listing units in two rows
Given I set the units per schedule to 2
	And I go to the list of schedules
When I follow 'edit' for schedule "Ruby I"
  And I press 'scheduled_units.update'
#Then I should see "Mon 11:15~12:15"
#	And I should see "Mon 13:00~15:00"
#	And I should not see "Mon 15:50~17:50"
	
Scenario: Scheduled units are generated and filled in
	And the following scheduled unit record
	|	id	|	date 			|	start_time	|	end_time	|	unit_id	|
	|	1		|	10/05/09	|	13:00				|	15:00			|	2				|
	And I go to the list of schedules
	And schedule "Ruby I" should have 1 scheduled unit
When I follow 'edit' for schedule "Ruby I"
Then schedule "Ruby I" should have 41 scheduled units
	And the "10/12 Mon 13:00~15:00" drop menu should contain "In the neiborhood"
	And the "10/19 Mon 13:00~15:00" drop menu should contain "My style, your style"
	And the "10/26 Mon 13:00~15:00" drop menu should contain "What's your schedule"
	And I should have 40 scheduled units
	
Scenario: If there are classes with no template classes, their units should be visible NOT IMPLEMENTED
Given the following class record
|	id	|	date 			|	start_time	|	end_time	| course 	|
|	1		|	10/05/09	|	14:00				|	15:00			|	Ruby I	|
	And I go to the list of schedules
When I follow 'edit' for schedule "Ruby I"
Then I should not see "10/5 Mon 14:00~15:00"

Scenario: If there are old scheduled units, they should not be visible
	And the following scheduled unit record
	|	id	|	date 			|	start_time	|	end_time	|	unit_id	|
	|	1		|	09/28/09	|	13:00				|	15:00			|	1				|
	And I go to the list of schedules
	And schedule "Ruby I" should have 1 scheduled unit
When I follow 'edit' for schedule "Ruby I"
	And schedule "Ruby I" should have 41 scheduled units
Then I should not see "9/28 Mon 13:00~15:00"