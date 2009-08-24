@change_courses
Background:
Given I have courses titled "Java I, Ruby I"
Given the following teacher records
|	user_name			|	password	| family_name	| first_name	|
|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
|	thomas_osburg	|	secret		|	Osburg			|	Thomas			|
|	prince_philip	|	secret		|	Prince			|	Philip			|
Given the following student record
|	user_name				|	password	|	first_name	|	family_name	|
|	kurosawa_akira	|	secret		|	Akira				|	Kurosawa		|
Given the following klass records
|	id	|	course	|
|	1		|	Java I	|
|	2		|	Java I	|
|	3		|	Ruby I	|
|	4		|	Ruby I	|
Given classes "2, 4" have teacher "prince_philip"
Given classes "3, 4" have student "kurosawa_akira"
Given I am logged in as "johan_sveholm"
	And I go to the list of classes

Scenario: Try to change course with blank class
	And I follow 'edit' within "klass_1"
	And I should not see 'students.title' within "students"
When I select "Ruby I" from 'course'
	And I press 'update'
Then I have 1 class "Java I"
	And I have 3 classes "Ruby I"
	And I should not see 'klasses.error.edit_courses_with_teacher'
	
Scenario: Try to change course with existing teacher	
	And I follow 'edit' within "klass_2"
	And I should not see 'students.title' within "students"
When I select "Ruby I" from 'course'
	And I press 'update'
Then I have 2 classes "Java I"
	And I have 2 class "Ruby I"
	And I should see 'klasses.error.edit_courses_with_teacher'
When I select no teacher
	And I press 'update'
Then I have 1 class "Java I"
	And I have 3 classes "Ruby I"
	And I should not see 'klasses.error.edit_courses_with_teacher'
	
Scenario: Try to change course with existing students
	And I follow 'edit' within "klass_3"
	And I should see 'students.title' within "students"
When I select "Java I" from 'course'
	And I press 'update'
Then I have 2 classes "Java I"
	And I have 2 class "Ruby I"
	And I should see 'klasses.error.edit_courses_with_students'
	
Scenario: Try to change course with existing teacher and students
	And I follow 'edit' within "klass_4"
	And I should see 'students.title' within "students"
When I select "Java I" from 'course'
	And I press 'update'
Then I have 2 classes "Java I"
	And I have 2 class "Ruby I"
	And I should see 'klasses.error.edit_courses_with_teacher'
	And I should see 'klasses.error.edit_courses_with_students'	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	