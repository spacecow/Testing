@create_classes
Background:
Given I have courses titled "Java I, Ruby I"
	And the following teacher records
|	user_name			|	password	| family_name	| first_name	|
|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	And I am logged in as "johan_sveholm"
	And I go to the list of classes

Scenario: Add a Class after getting Errors
Given I should have 0 classes
When I follow 'klasses.new'
Then I should see 'klasses.new' within "form"
When I press 'create'
Then I should have 0 classes
	And I should see "Course "'activerecord.errors.messages.blank'
	And I should see "Start time "'activerecord.errors.messages.blank'
	And I should see "End time "'activerecord.errors.messages.blank'
When I fill in 'start_time' with "13:00"
	And I fill in 'end_time' with "15:00"
	And I press 'create'
Then I should have 0 classes
	And I should see "Course "'activerecord.errors.messages.blank'
	And I should not see "Start time "'activerecord.errors.messages.blank'
	And I should not see "End time "'activerecord.errors.messages.blank'	
When I select "Java I" from 'course'
	And I press 'create'
Then I should see 'klasses.listing'
	And I should see "Java"'blank''course'
	And I should see "13:00~15:00"
	And I should have 1 class
