@change_template_courses
Background:
Given I have courses titled "Java I, Ruby I"
	And the following teacher records
	|	user_name			|	password	| family_name	| first_name	|
	|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
	|	thomas_osburg	|	secret		|	Osburg			|	Thomas			|
	|	prince_philip	|	secret		|	Prince			|	Philip			|
	And the following template class records
	|	id	|	course	|
	|	1		|	Java I	|
	|	2		|	Java I	|
	|	3		|	Ruby I	|
	|	4		|	Ruby I	|
	And template classes "2, 4" have teacher "prince_philip"

Scenario: Try to change course with blank class
Given I am logged in as "johan_sveholm" AJAX
	And I browse to "template_classes"
	And I click link 'edit' for "Java" template class 1
When I select option "Ruby I" from "template_class_course_id"
Then I should have 1 template class "Java I"
	And I should have 3 template classes "Ruby I"