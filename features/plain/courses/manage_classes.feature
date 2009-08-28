@classes_in_courses
Background:
Given I have courses titled "Java I, Ruby I, Fortran I"
	And the following teacher records
	|	user_name			|	password	| family_name	| first_name	|
	|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
	And the following klass record
	|	id	|	course		|	teacher				|
	|	1		|	Java I		|	johan_sveholm	|
	|	2		|	Java I		|	komatsu_aya		|
  And the following template klass record
	|	id	|	course		|	teacher				|
	|	1		|	Java I		|	johan_sveholm	|
	|	2		|	Java I		|	komatsu_aya		|
  And the following student record
  |	user_name				|	password	|
  |	kurosawa_akira	|	secret		|
	And student "kurosawa_akira" has class "2"
	And I am logged in as "johan_sveholm"
	And I go to the list of courses
	And I follow 'edit' within "Java_I"
	
Scenario: Delete classes
Given I should have 2 classes
When I follow 'delete' within "klass_2"
Then I should be redirected to the edit page of course "Java I"
	And I should see 'klasses.error.try_to_delete_klass_with_students'
	And I should have 2 classes
When I follow 'delete' within "klass_1"
Then I should be redirected to the edit page of course "Java I"
	And I should not see 'klasses.error.try_to_delete_klass_with_students'
	And I should have 1 class
	
Scenario: Edit a class and show the result
When I follow 'edit' within "klass_1"
	And I fill in 'note' with "Something important"
	And I fill in 'title' with "Some title"
	And I press 'update'
Then I should be redirected to the edit page of course "Java I"
When I follow "12:00~15:00" within "klass_1"
Then I should see 'title'": Some title"
	And I should see 'note'": Something important"
	
Scenario: Delete template classes
Given I should have 2 template classes
When I follow 'delete' within "template_klass_1"
Then I should be redirected to the edit page of course "Java I"
	And I should have 1 template class
When I follow 'delete' within "template_klass_2"
Then I should be redirected to the edit page of course "Java I"
	And I should have 0 template classes	

Scenario: Edit a template class and show the result
When I follow 'edit' within "template_klass_1"
	And I fill in 'note' with "Something important"
	And I fill in 'title' with "Some title"
	And I press 'update'
Then I should be redirected to the edit page of course "Java I"
When I follow "12:00~15:00" within "template_klass_1"
Then I should see 'title'": Some title"
	And I should see 'note'": Something important"