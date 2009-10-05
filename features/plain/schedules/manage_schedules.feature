Background:
Given the following teacher records
|	user_name			|	language	|	password	|
|	johan_sveholm	|	en				|	secret		|
|	komatsu_aya		|	ja				|	secret		|
Given I go to the list of schedules
	
Scenario Outline: Course id has to be filled in to create a schedule
Given I am logged in as "<user>"
	And I follow 'schedules.new' within "links"
	And I should be redirected to the new page of schedule
When I press 'create'
Then I should see "Course "'activerecord.errors.messages.blank'
Examples:
| user 					|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Course id has to be unique to create a schedule
Given I am logged in as "<user>"
	And I have course "Ruby I"
	And I have schedule "Ruby I"
	And I follow 'schedules.new' within "links"
When I select "Ruby I" from 'course'
	And I press 'create'
Then I should see "Course "'activerecord.errors.messages.taken'
Examples:
| user 					|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Create a schedule
Given I am logged in as "<user>"
	And I have course "Ruby I"
	And I follow 'schedules.new' within "links"
When I select "Ruby I" from 'course'
	And I press 'create'
Then I should be redirected to the list of schedules
And I should see 'schedule''created'
And I should see "Ruby I" within "list"
Examples:
| user 					|
|	johan_sveholm	|
|	komatsu_aya		|