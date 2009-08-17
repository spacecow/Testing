@ajax
Scenario: Messing around with teachers
Given I have courses titled "Java I, Java II, Java III, Ruby I"
	And the following teacher records
	| user_name 		|	password	|	first_name	|	family_name	|
	|	johan_sveholm	|	secret		|	Johan				|	Sveholm			|
	|	komatsu_aya		|	secret		|	Aya					|	Komatsu			|
	|	thomas_osburg	|	secret		|	Thomas			|	Osburg			|
  And that teacher "johan_sveholm" has course "Java I"
  And that teacher "komatsu_aya" has courses "Java I, Java II, Java III"
  And that teacher "thomas_osburg" has course "Java I, Ruby I"
  And the following klass records
  |	id	|	course		|
  |	1		|	Java I		|
  |	2		|	Java I		|
  |	3		|	Java I		|
  |	4		|	Java II		|
  |	5		|	Java III	|
  |	6		|	Ruby I		|
When I am logged in as "johan_sveholm" AJAX
Then I should see teacher options "Sveholm Johan, Komatsu Aya, Osburg Thomas" for "Java" class 1
	And I should see teacher options "Sveholm Johan, Komatsu Aya, Osburg Thomas" for "Java" class 2
	And I should see teacher options "Sveholm Johan, Komatsu Aya, Osburg Thomas" for "Java" class 3
	And I should see teacher options "Komatsu Aya" for "Java" class 6
	And I should see teacher options "Komatsu Aya" for "Java" class 9
	And I should see teacher options "Osburg Thomas" for "Ruby" class 1
When I select "Osburg Thomas" for "Ruby" class 1 as teacher
	And I select "Komatsu Aya" for "Java" class 6 as teacher
Then I should see teacher options "Sveholm Johan" for "Java" class 1
	And I should see teacher options "Sveholm Johan" for "Java" class 2
	And I should see teacher options "Sveholm Johan" for "Java" class 3
	And I should see teacher options "Komatsu Aya" for "Java" class 6
	And I should see no teacher options for "Java" class 9
	And I should see teacher options "Osburg Thomas" for "Ruby" class 1
When I unselect teacher for "Java" class 6
	And I select "Komatsu Aya" for "Java" class 1 as teacher
	And I select "Sveholm Johan" for "Java" class 2 as teacher
Then I should see teacher options "Komatsu Aya" for "Java" class 1
	And I should see teacher options "Sveholm Johan" for "Java" class 2
	And I should see no teacher options for "Java" class 3
	And I should see no teacher options for "Java" class 6
	And I should see no teacher options for "Java" class 9
	And I should see teacher options "Osburg Thomas" for "Ruby" class 1	

