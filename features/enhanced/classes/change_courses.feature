@ejax
Background:
Given I have courses titled "Java I, Ruby I, Fortran II"
	And the following teacher records
	|	user_name			|	password	| family_name	| first_name	|
	|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
	|	thomas_osburg	|	secret		|	Osburg			|	Thomas			|
	|	prince_philip	|	secret		|	Prince			|	Philip			|
	And the following klass records
	|	id	|	course	|
	|	1		|	Java I	|
	|	2		|	Java I	|
	|	3		|	Ruby I	|
	|	4		|	Ruby I	|
	And teacher "prince_philip" has courses "Java I, Ruby I"
	And classes "2, 4" have teacher "prince_philip"

Scenario: Change course with blank teacher
Given I am logged in as "johan_sveholm" AJAX
	And I browse to "klasses"
	And I click link 'edit' for "Java" class 1
When I select option "Ruby I" from "klass_course_id"
Then I should not see text 'klasses.error.edit_courses_with_teacher'
	And I should have 1 class "Java I"
	And I should have 3 classes "Ruby I"
	
Scenario: Try to change course with existing teacher
Given I am logged in as "johan_sveholm" AJAX
	And I browse to "classes"
	And I click link 'edit' for "Java" class 2
When I select option "Fortran II" from "klass_course_id"
Then I should see text 'klasses.error.edit_courses_with_teacher'
	And I should have 2 classes "Java I"
	And I should have 2 classes "Ruby I"
	And wait
When I select option blank from "klass_teacher_id"
	And I select option "Fortran II" from "klass_course_id"
Then I should see text 'klasses.listing'
	And I should have 1 class "Java I"
	And I should have 2 classes "Ruby I"
	And I should have 1 class "Fortran II"
	
Scenario: Try to change course with existing teacher	
Given I am logged in as "johan_sveholm"
	And I go to the list of classes
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
Given I am logged in as "johan_sveholm"
	And I go to the list of classes
	And I follow 'edit' within "klass_3"
	And I should see 'students.title' within "students"
When I select "Java I" from 'course'
	And I press 'update'
Then I have 2 classes "Java I"
	And I have 2 class "Ruby I"
	And I should see 'klasses.error.edit_courses_with_students'
	
Scenario: Try to change course with existing teacher and students
Given I am logged in as "johan_sveholm"
	And I go to the list of classes
	And I follow 'edit' within "klass_4"
	And I should see 'students.title' within "students"
When I select "Java I" from 'course'
	And I press 'update'
Then I have 2 classes "Java I"
	And I have 2 class "Ruby I"
	And I should see 'klasses.error.edit_courses_with_teacher'
	And I should see 'klasses.error.edit_courses_with_students'		