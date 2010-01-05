#
#Background:
#Given I have courses titled "Java I, Ruby I, Fortran I"
#	And the following teacher records
#	|	user_name			|	password	| family_name	| first_name	|
#	|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
#	|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
#  And the following template klass record
#	|	id	|	course		|	teacher				| day 		|
#	|	1		|	Java I		|	johan_sveholm	| Sunday 	|
#	|	2		|	Java I		|	komatsu_aya		|	Sunday	|
#	And I am logged in as "johan_sveholm"
#	And I go to the "Sunday" list of template classes
#

#
#Scenario: Delete Template Classes
#Given I should have 2 template classes
#When I follow 'delete' within "template_klass_1"
#Then I should be redirected to the list of template classes
#	And I should have 1 template class
#When I follow 'delete' within "template_klass_2"
#Then I should be redirected to the list of template classes
#	And I should have 0 template classes	
#
#Scenario: Edit a template class and show the result
#When I follow 'edit' within "template_klass_1"
#	And I fill in 'note' with "Something important"
#	And I fill in 'title' with "Some title"
#	And I press 'update'
#Then I should be redirected to the list of template classes
#When I follow 'info' within "template_klass_1"
#Then I should see 'title'": Some title"
#	And I should see 'note'": Something important"
#	And I should have 2 template classes

Background:
Given a setting exist with name: "main"
	And a user exist with username: "johan", role: "admin", language: "en"
	
@template_classes
Scenario: Create a new template class
Given a course exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a user exists with username: "kurosawa", name: "Akira Kurosawa", role: "teacher"
	And a classroom exists with name: "1"
	And a user is logged in as "johan"
When I go to the new template class page
Then "template_class_course_id" should have options "BLANK, Ruby I, Rails II"
	And "template_class_teacher_id" should have options "BLANK, Akira Kurosawa"
	And "template_class_classroom_id" should have options "BLANK, 1"
Then show me the page
When I press "Create"
Then I should see "Course*Ruby IRails IIcan't be blank"
Then I should see "Start time*fe"
Then show me the page