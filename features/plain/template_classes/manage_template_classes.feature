@template_classes
Background:
Given I have courses titled "Java I, Ruby I, Fortran I"
	And the following teacher records
	|	user_name			|	password	| family_name	| first_name	|
	|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
  And the following template klass record
	|	id	|	course		|	teacher				| day 		|
	|	1		|	Java I		|	johan_sveholm	| Sunday 	|
	|	2		|	Java I		|	komatsu_aya		|	Sunday	|
	And I am logged in as "johan_sveholm"
	And I go to the "Sunday" list of template classes

Scenario: Delete Template Classes
Given I should have 2 template classes
When I follow 'delete' within "template_klass_1"
Then I should be redirected to the list of template classes
	And I should have 1 template class
When I follow 'delete' within "template_klass_2"
Then I should be redirected to the list of template classes
	And I should have 0 template classes	

Scenario: Edit a template class and show the result
When I follow 'edit' within "template_klass_1"
	And I fill in 'note' with "Something important"
	And I fill in 'title' with "Some title"
	And I press 'update'
Then I should be redirected to the list of template classes
When I follow 'info' within "template_klass_1"
Then I should see 'title'": Some title"
	And I should see 'note'": Something important"
	And I should have 2 template classes