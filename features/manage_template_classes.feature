@template_klasses
Scenario Outline: Delete Template Classes
  Given I have courses titled "入門 I, 入門 II"
  Given the following teacher record
  |	id	| user_name     | password |
  |	1		| johan_sveholm | secret   |  
  Given the following template klass record
	|	id	|	course	| start_time	|	end_time	|	teacher_id	|
	|	1		|	入門 I		| 11:00				| 12:00			|	1						|
	Given I go to the list of <list>
	And I am logged in as "johan_sveholm" with password "secret"
	And I should see '<list>.listing'
	And I <extra>
	And I <extra2>
	And I should have 1 template klass
	And I should have 1 teacher
	When I follow 'delete' within "template_klass_1"
	Then I should have 0 template klasses
	And I should have 1 teacher
	Examples:
	|	list							|	extra																		|	extra2																			|
	|	template_klasses	|	should see "入門コース"										|	should see "11:00~12:00"										|
	|	courses						|	should see "入門 I"											|	follow 'show' in the row containing "入門 I"	|
	|	template_klasses	| follow 'show' within "template_klass_1"	| follow "入門 I"															|

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

Scenario Outline: Edit a Template Class and show the Result
  Given I have courses titled "入門 I, 入門 II"
  Given the following teacher record
  |	id	|	user_name     | password |	language	|	first_name	|	family_name	|
  | 1		|	johan_sveholm | secret   |	en				|	Johan				|	Sveholm			|
  Given the following template klass record
	|	id	|	course	|	start_time	|	end_time	| teacher_id	|
	|	1		|	入門 I		|	13:00				| 15:00			|	1						|
	Given I go to the list of <list>
	And I am logged in as "johan_sveholm" with password "secret"
	And I <extra>
	When I follow <edit>
	And I fill in 'note' with "Something important"
	And I fill in 'title' with "Some title"
	And I press 'update'
	And I follow 'show' within "template_klass_1"
	Then I should see 'course'": 入門 I"
	And I should see 'teacher'": Sveholm Johan"
	And I should see 'capacity'": 0"
	And I should see todays day
	And I should see 'klass_time'": 13:00~15:00"
	And I should see 'title'": Some title"
	And I should see 'inactive'": false"
	And I should see 'mail_sending'": 0"	
	And I should see 'note'": Something important"
	And I should have 1 template klasses
	Examples:
	|	list							|	extra																				|	edit															|
	| template klasses	| should see "入門コース"												|	'edit' within "template_klass_1"	|
	| courses						| follow 'show' in the row containing "入門 I"	|	'edit' within "template_klass_1"	|
	|	template klasses	|	follow 'show' within "template_klass_1"			| 'edit'														|