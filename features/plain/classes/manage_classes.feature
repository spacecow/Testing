@create_classes
Background:
Given I have courses titled "Java I, Ruby I, Fortran I"
	And the following teacher records
	|	user_name			|	password	| family_name	| first_name	|
	|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
	And the following klass record
	|	id	|	course		|	start_time	|	end_time	|	teacher				|
	|	1		|	Java I		|	11:00				| 12:00			|	johan_sveholm	|
	|	2		|	Java I		|	11:00				| 13:00			|	komatsu_aya		|
  And the following student record
  |	user_name				|	password	|
  |	kurosawa_akira	|	secret		|
	And student "kurosawa_akira" has class "2"
	And I am logged in as "johan_sveholm"
	And I go to the list of classes

Scenario: Add a Class after getting Errors
Given I should not see "Fortran"'blank''course'
	And I should have 2 classes
When I follow 'klasses.new'
Then I should see 'klasses.new' within "form"
When I press 'create'
Then I should have 2 classes
	And I should see "Course "'activerecord.errors.messages.blank'
	And I should see "Start time "'activerecord.errors.messages.blank'
	And I should see "End time "'activerecord.errors.messages.blank'
When I fill in 'start_time' with "13:00"
	And I fill in 'end_time' with "15:00"
	And I press 'create'
Then I should have 2 classes
	And I should see "Course "'activerecord.errors.messages.blank'
	And I should not see "Start time "'activerecord.errors.messages.blank'
	And I should not see "End time "'activerecord.errors.messages.blank'	
When I select "Fortran I" from 'course'
	And I press 'create'
Then I should see 'klasses.listing'
	And I should see "Fortran"'blank''course'
	And I should see "13:00~15:00"
	And I should have 3 classes

Scenario: Delete Classes
When I follow 'delete' within "klass_2"
Then I should see 'klasses.error.try_to_delete_klass_with_students'
	And I should have 2 classes
	And class "1" should have teacher "johan_sveholm"
	And class "2" should have teacher "komatsu_aya"
	And class "2" should have student "kurosawa_akira"
	And I should have 2 teachers
	And teacher "johan_sveholm" should have class "1"
	And teacher "komatsu_aya" should have class "2"
	And I should have 1 student
	And student "kurosawa_akira" should have class "2"
	And I should have 1 attendance
When I follow 'delete' within "klass_1"
	Then I should have 1 klass
	And class "2" should have teacher "komatsu_aya"
	And class "2" should have student "kurosawa_akira"
	And I should have 2 teachers
	And I should have 1 student	
	And teacher "johan_sveholm" should have class "1"
	And teacher "komatsu_aya" should have class "2"
	And student "kurosawa_akira" should have class "2"
	And I should have 1 attendance
	
Scenario: Duplicate a Generated Class
Given I should have 2 klasses
When I follow "+" within "Java_I_1100_1200"
Then I should have 3 klasses
When I follow 'show' within "klass_1"
	Then I should see 'course'": Java I"
	And I should see 'teacher'": Sveholm Johan"
	And I should see 'capacity'": 0"
	And I should see todays date
	And I should see 'klass_time'": 11:00~12:00"
	And I should see 'cancel'": false"
	And I should see 'mail_sending'": 0"
When I follow 'back'
	And I follow 'show' within klass 3
Then I should see 'course'": Java I"
	And I should not see 'teacher'": Sveholm Johan"
	And I should see 'capacity'": 0"
	And I should see todays date
	And I should see 'klass_time'": 11:00~12:00"
	And I should see 'cancel'": false"
	And I should see 'mail_sending'": 0"
	
Scenario: Edit a class and show the result
When I follow 'edit' within "klass_1"
	And I fill in 'note' with "Something important"
	And I fill in 'title' with "Some title"
	And I press 'update'
	And I follow 'show' within "klass_1"
Then I should see 'title'": Some title"
	And I should see 'note'": Something important"