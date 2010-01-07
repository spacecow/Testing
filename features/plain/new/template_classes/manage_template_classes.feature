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

@visual
Background:
Given a setting exist with name: "main"
	And a user exist with username: "johan", role: "admin", language: "en"
	
Scenario: Create a new template class
Given a course: "ruby" exists with name: "Ruby I"
	And a course exists with name: "Rails II"
	And a user: "kurosawa" exists with username: "kurosawa", name: "Akira Kurosawa", role: "teacher"
	And a classroom: "1" exists with name: "1"
	And a user is logged in as "johan"
When I go to the new template class page
	And I fill in "Title" with "A funny title"
	And I select "Ruby I" from "Course"
	And I select "Monday" from "Day"
	And I select "1" from "Classroom"
	And I fill in "Description" with "A funny description"
	And I fill in "Note" with "A funny note"
	And I press "Create"
Then I should be redirected to the error template classes page
	And "Ruby I" should be selected in the "Course" box
	And "Monday" should be selected in the "Day" box
	And "1" should be selected in the "Classroom" box
When I fill in "Start time" with "18:50"
	And I fill in "End time" with "20:50"
	And I press "Create"
Then I should be redirected to the template classes page
	And I should see "Successfully created template class" within "#notice"
	And a template class should exist with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "Mon"
	