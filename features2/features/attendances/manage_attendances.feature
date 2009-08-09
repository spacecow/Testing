@attendances
Scenario: Hejsan
Given I have courses titled "Java I, Java II, Java III, Ruby I"
	And I have teacher "johan_sveholm"
  And the following student record
  |	user_name				|	password	|	first_name	|	family_name	|
  |	kurosawa_akira	|	secret		|	Akira				|	Kurosawa		|
	And the following klass record
	|	id	|	course	|
	|	1		|	Java I	|
	And I am logged in as "johan_sveholm"
	And I should be redirected to the list of klasses
	And student "kurosawa_akira" has class "1"
	And I should see "Kurosawa Akira"