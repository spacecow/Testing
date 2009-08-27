@courses
Background:
Given I have courses titled "Java I, Java II, Rails II, Ruby I, Fortran I"
  And the following template klass record
	|	course		|	day				| start_time	|	end_time	|
	|	Java I		|	Friday		| 11:00				| 12:00			|
	|	Fortran I	|	Saturday	|	13:00				|	13:50			|
  And the following klass records
	|	course		|	date			| start_time	|	end_time	|
	|	Java I		|	06/30/09	| 11:00				| 11:50			|
	|	Rails II	|	07/01/09	|	12:00				|	14:00			|
	And I go to the list of courses
	And I have teacher "johan_sveholm"
	And I am logged in as "johan_sveholm"
	
Scenario Outline: Trying to Delete Courses
When I follow 'delete' within "<delete>"
Then I should <error_1> 'courses.error.try_to_delete_course_with_template_classes'
	And I should <error_2> 'courses.error.try_to_delete_course_with_klasses'	
	And I should <item_1> "Java I"
	And I should <item_2> "Java II"	
	And I should <item_3> "Rails II"
	And I should <item_4> "Ruby I"
	And I should <item_5> "Fortran I"	
	And I should have <courses> courses
Examples:
|	delete		|	error_1	|	error_2	|	item_1	|	item_2	|	item_3	|	item_4	|	item_5	| courses	|
|	Java_I		|	see			|	see			|	see			|	see			|	see			|	see			|	see			|	5				|
|	Java_II		|	not see	|	not see	|	see			|	not see	|	see			|	see			|	see			|	4				|
|	Rails_II	|	not see	|	see			|	see			|	see			|	see			|	see			|	see			|	5				|
|	Ruby_I		|	not see	|	not see	|	see			|	see			|	see			|	not see |	see			|	4				|
|	Fortran_I	|	see			|	not see	|	see			|	see			|	see			|	see			|	see			|	5				|

Scenario Outline: Displaying Associations
When I follow 'show' within "<show>"
Then I should <day_1> "Friday"
	And I should <time_1> "11:00~12:00"
	And I should <day_2> "Saturday"
	And I should <time_2> "13:00~13:50"	
	And I should <day_3> "Tuesday"
	And I should <time_3> "11:00~11:50"
	And I should <day_4> "Wednesday"
	And I should <time_4> "12:00~14:00"	
Examples:
|	show			|	day_1		| time_1	|	day_2		| time_2	| day_3		|	time_3	| day_4		|	time_4	|
|	Java_I		|	see			| see			| not see	|	not see	|	see			|	see			|	not see |	not see	|
|	Java_II		|	not see	| not see	| not see	| not see	|	not see	|	not see	|	not see	|	not see	|
|	Rails_II	|	not see	| not see	| not see	| not see	|	not see	| not see	|	see			|	see			|
|	Ruby_I		|	not see	| not see	| not see	| not see	|	not see	| not see	|	not see	|	not see	|
|	Fortran_I	|	not see	| not see	| see			| see			|	not see	| not see	|	not see	|	not see	|