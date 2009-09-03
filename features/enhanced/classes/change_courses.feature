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
	