@delete_teachers
Background:
Given the following teacher records
|	user_name			|	password	|
|	johan_sveholm	|	secret		|
| komatsu_aya		|	secret		|
| prince_philip	|	secret		|
And I go to the list of teachers

Scenario Outline: Delete a teacher with no associations
Given I am logged in as "<user>" with password "secret"
	And I should have 3 persons
	And I should have 3 teachers
When I try to delete teacher "prince_philip"
Then I should see a notice "Teacher was successfully deleted"
	And I should have 2 teachers
	And I should have 2 persons
Examples:
|	user	|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Try to delete a teacher with course associations
Given I am logged in as "<user>" with password "secret"
	And I have courses titled "Ruby on Rails, Python"
	And that teacher "prince_philip" has course "Ruby on Rails"
When I try to delete teacher "prince_philip"
Then I should see an error 'teachers.error.delete_teacher_with_courses'
	And teacher "prince_philip" should have 1 course
	And course "Ruby on Rails" should have 1 teacher
	And course "Python" should have 0 teachers
	And I should have 1 teaching
	And I should have 2 courses
Examples:
|	user	|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Try to delete a teacher with course&class associations
Given I am logged in as "<user>" with password "secret"
	And I have courses titled "Ruby on Rails, Python"
	And that teacher "prince_philip" has course "Ruby on Rails"
	And that teacher "prince_philip" has class "Ruby on Rails"
When I try to delete teacher "prince_philip"
Then I should see an error 'teachers.error.delete_teacher_with_courses'
	And I should see an error 'teachers.error.delete_teacher_with_classes'
	And teacher "prince_philip" should have 1 course
	And course "Ruby on Rails" should have 1 teacher
	And course "Python" should have 0 teachers
	And I should have 1 teaching
	And I should have 2 courses
	And teacher "prince_philip" should have 1 class
	And class "Ruby on Rails" should have a teacher
Examples:
|	user	|
|	johan_sveholm	|
|	komatsu_aya		|