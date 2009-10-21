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
	And I am logged in as "johan_sveholm" AJAX
	
Scenario: If one changes unit, following units should update
Given I browse to "schedules"
	And I click link 'edit' for schedule "Ruby I"
When I select option "Nice to meet you" from "10/19_Mon_11:15~12:15"
Then I should see option "Nice to meet you" for "10/19_Mon_11:15~12:15"
And wait
Then I should see option "Family and Feelings" for "11/02_Mon_11:15~12:15"