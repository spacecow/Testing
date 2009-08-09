@delete_teachers
Feature: Delete Teachers

Background:
Given the following teacher record
|	user_name			|	password	|
|	johan_sveholm	|	secret		|
Given I am logged in as "johan_sveholm" with password "secret"
	And I go to the list of teachers
	And I should have 1 person
	And I should have 1 teacher

Scenario: Delete a teacher with no associations
When I try to delete teacher "johan_sveholm"
Then I should see a notice "Teacher was successfully deleted"
	And I should have 0 teachers
	And I should have 0 persons

Scenario: Try to delete a teacher with course associations
Given I have courses titled "Ruby on Rails, Python"
	And that teacher "johan_sveholm" has course "Ruby on Rails"
When I try to delete teacher "johan_sveholm"
Then I should see an error 'teachers.error.delete_teacher_with_courses'
	And teacher "johan_sveholm" should have 1 course
	And course "Ruby on Rails" should have 1 teacher
	And course "Python" should have 0 teachers
	And I should have 1 teaching
	And I should have 2 courses

Scenario: Try to delete a teacher with course&class associations
Given I have courses titled "Ruby on Rails, Python"
	And that teacher "johan_sveholm" has course "Ruby on Rails"
	And that teacher "johan_sveholm" has class "Ruby on Rails"
When I try to delete teacher "johan_sveholm"
Then I should see an error 'teachers.error.delete_teacher_with_courses'
	And I should see an error 'teachers.error.delete_teacher_with_classes'
	And teacher "johan_sveholm" should have 1 course
	And course "Ruby on Rails" should have 1 teacher
	And course "Python" should have 0 teachers
	And I should have 1 teaching
	And I should have 2 courses
	And teacher "johan_sveholm" should have 1 class
	And class "Ruby on Rails" should have a teacher
