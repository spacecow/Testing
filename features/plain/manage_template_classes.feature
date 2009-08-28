@template
Scenario: Duplicate a Template Class
  Given I have courses titled "入門 I, 入門 II"
  Given the following teacher record
  | user_name     | password |	language	|
  | johan_sveholm | secret   |	en				|
  Given the following template klass record
	|	course	|	start_time	|	end_time	|
	|	入門 I		|	11:00				| 12:00			|
	Given I go to the list of template klasses
	And I am logged in as "johan_sveholm" with password "secret"
	And I should have 1 template klass
	When I follow "+" within "入門_I_1100_1200"
	Then I should have 2 template klasses

Scenario: Add a Template Class after getting Errors
  Given I have courses titled "入門 I, 入門 II"
  Given the following teacher record
  | user_name     | password |	language	|
  | johan_sveholm | secret   |	en				|
	Given I go to the list of template klasses
	And I am logged in as "johan_sveholm" with password "secret"
	And I should have 0 template klasses
	When I follow 'template_klasses.new'
	And I should see 'template_klasses.new'
	And I press 'create'
	And I should have 0 template klasses
	Then I should see "Course "'activerecord.errors.messages.blank'
	And I should see "Start time "'activerecord.errors.messages.blank'
	And I should see "End time "'activerecord.errors.messages.blank'
	When I fill in 'start_time' with "13:00"
	And I fill in 'end_time' with "15:00"
	And I press 'create'
	And I should have 0 template klasses
	Then I should see "Course "'activerecord.errors.messages.blank'
	And I should not see "Start time "'activerecord.errors.messages.blank'
	And I should not see "End time "'activerecord.errors.messages.blank'	
	When I select "入門 I" from 'course'
	And I press 'create'
	Then I should see 'template_klasses.listing'
	And I should see "入門コース"
	And I should see "13:00~15:00"
	And I should have 1 template klass