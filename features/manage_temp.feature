@temp
Scenario Outline: Delete Classes
  Given I have courses titled "入門 I, 入門 II"
  Given the following teacher record
  | id	|	user_name     | password	|
  | 1		|	johan_sveholm | secret		|
  |	2		|	komatsu_aya		|	secret		|
  Given the following student record
  |	id	|	user_name				|	password	|
  |	1		|	kurosawa_akira	|	secret		|
  Given the following klass record
	|	id	|	course	|	start_time	|	end_time	|	teacher_id	|
	|	1		|	入門 I		|	11:00				| 12:00			|	1						|
	|	2		|	入門 I		|	11:00				| 12:00			|	2						|
	Given the following attendance record
	| klass_id	|	student_id	|
	|	2					|	1						|
	Given I go to the list of <list>
	And I am logged in as "johan_sveholm" with password "secret"
	And I should see '<list>.listing'
	And I <extra>
	And I <extra2>
	And I should have 2 klasses
	And I should have 2 teachers
	And I should have 1 student
	When I follow 'delete' within "klass_2"
	Then I should see 'klasses.flash.try_to_delete_klass_with_students'
	And I should have 2 klasses
	And I should have 2 teachers
	And I should have 1 student
	When I follow 'delete' within "klass_1"
	And I should have 1 klass
	And I should have 2 teachers
	And I should have 1 student	
	Examples:
	|	list		| extra														|	extra2																			|
	|	klasses	|	should see "入門コース"						|	should see "11:00~12:00"										|
	|	courses	|	should see "入門 I"							|	follow 'show' in the row containing "入門 I"	|
	|	klasses	| follow 'show' within "klass_2"	| follow "入門 I"															|