@delete_students
Background:
Given the following teacher records
|	user_name			|	password	|
|	johan_sveholm	|	secret		|
| komatsu_aya		|	secret		|
Given the following student record
|	user_name				|	password	|
|	kurosawa_akira	|	secret		|
And I go to the list of students

Scenario Outline: Delete a student with no associations
Given I am logged in as "<user>" with password "secret"
	And I should have 3 persons
	And I should have 2 teachers
	And I should have 1 student
When I try to delete student "kurosawa_akira"
Then I should see a notice "Student was successfully deleted"
	And I should have 2 persons
	And I should have 2 teachers
Examples:
|	user	|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Try to delete a student with course associations
Given I am logged in as "<user>" with password "secret"
	And I have courses titled "Ruby on Rails, Python"
	And that student "kurosawa_akira" has course "Ruby on Rails"
When I try to delete student "kurosawa_akira"
Then I should see an error 'students.error.delete_student_with_courses'
	And student "kurosawa_akira" should have 1 course
	And course "Ruby on Rails" should have 1 student
	And course "Python" should have 0 students
	And I should have 1 courses_student
	And I should have 2 courses
Examples:
|	user	|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Try to delete a student with course&class associations
Given I am logged in as "<user>" with password "secret"
	And I have courses titled "Ruby on Rails, Python"
	And that student "kurosawa_akira" has course "Ruby on Rails"
	And that student "kurosawa_akira" has class "Ruby on Rails"
When I try to delete student "kurosawa_akira"
Then I should see an error 'students.error.delete_student_with_courses'
	And I should see an error 'students.error.delete_student_with_classes'
	And student "kurosawa_akira" should have 1 class
	And class "Ruby on Rails" should have 1 student
Examples:
|	user	|
|	johan_sveholm	|
|	komatsu_aya		|