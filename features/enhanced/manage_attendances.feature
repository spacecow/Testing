Scenario: Messing around with students
Given I have courses titled "Java I, Java II, Java III, Ruby I"
	And I have teacher "johan_sveholm"
  And the following klass records
  |	id	|	course		|
  |	1		|	Java I		|
  |	2		|	Java I		|
  |	3		|	Java I		|
  |	4		|	Java II		|
  |	5		|	Java III	|
  |	6		|	Ruby I		|
  And the following student record
  |	user_name					|	password	|	first_name	|	family_name	|
  |	kurosawa_akira		|	secret		|	Akira				|	Kurosawa		|
  |	asada_mao					|	secret		|	Mao					|	Asada				|
  |	sakurai_kazutoshi	|	secret		|	Kazutoshi		|	Sakurai			|
	And student "kurosawa_akira" has class "1"
	And student "asada_mao" has class "1"
	And student "sakurai_kazutoshi" has class "1"
	And I am logged in as "johan_sveholm" AJAX
When I choose "Kurosawa Akira" for class 1 as student 2
	And I choose "Asada Mao" for class 1 as student 3
	And I move "asada_mao" from class 1 to class 2
	And I move "sakurai_kazutoshi" from class 1 to class 2
Then I should see "Kurosawa Akira" for class 1 as student 1
	And I should see "Asada Mao" for class 2 as student 2
	And I should see "" for class 2 as student 1
	And I should not see any students for class 3
When I choose "" for class 1 as student 1
	And I choose "Kurosawa Akira" for class 2 as student 1
	And I move "asada_mao" from class 2 to class 3
Then I should see "" for class 1 as student 1
	And I should see "Kurosawa Akira" for class 2 as student 1
	And I should see "Asada Mao" for class 3 as student 1
When I choose "Sakurai Kazutoshi" for class 3 as student 1
	And I move "asada_mao" from class 1 to class 3
	And I move "kurosawa_akira" from class 2 to class 3
	And I choose "Asada Mao" for class 3 as student 2
Then I should not see any students for class 1
	And I should not see any students for class 2
	And I should see "Kurosawa Akira" for class 3 as student 1
	And I should see "Asada Mao" for class 3 as student 2
	And I should see "Sakurai Kazutoshi" for class 3 as student 3
	And I should have 3 attendances
When I cancel "asada_mao" for class 3
	And I move "kurosawa_akira" from class 3 to class 1
Then I should see "Kurosawa Akira" for class 1 as student 1
	And I should not see any students for class 2
	And I should see "Sakurai Kazutoshi" for class 3 as student 1
	And I should have 3 attendances
When I delete "sakurai_kazutoshi" for class 3
	And I move "kurosawa_akira" from class 1 to class 2
Then I should not see any students for class 1
	And I should see "Kurosawa Akira" for class 2 as student 1
	And I should not see any students for class 3
	And I should have 2 attendances
When I delete "kurosawa_akira" for class 2
Then I should not see any students for class 1
	And I should not see any students for class 2
	And I should not see any students for class 3
	And I should have 1 attendance
	