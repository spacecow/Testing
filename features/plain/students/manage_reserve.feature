@admin
Scenario Outline: Admins Reserve Classes
  Given I have courses titled "Java I, Java II, Ruby I"
  Given the following teacher record
  |	user_name 		|	password	|
  |	johan_sveholm	|	secret		|
	|	komatsu_aya		|	secret		|
	Given the following student record
	| user_name				|	password	|
	|	kurosawa_akira	|	secret		|
	Given the following klass record
	|	id	| course	| date 					|	start_time	|	end_time	|
	|	1		|	Java I	|	current date	| 11:00				|	12:00			|
	|	2		|	Java II	|	current date	| 11:00				|	12:00			|
	|	3		|	Java I	|	current date	| 11:00				|	12:00			|
	|	4		|	Java I	|	06/01/09			| 11:10				|	12:00			|
	|	5		|	Java II	|	06/02/09			| 11:10				|	12:00			|
	|	6		|	Ruby I	|	current date	| 13:00				|	13:30			|
	Given student "kurosawa_akira" has courses "Java I, Java II"
		And student "kurosawa_akira" has classes "4, 5"
		And student "kurosawa_akira" has class "5" canceled
		And I am logged in as "<login>" with password "<password>"
		And I go to the reserve page of student "kurosawa_akira"
		And the "Java I" checkbox should be checked
		And the "Java II" checkbox should be checked
		And the "Java I: 11:00~12:00" checkbox should not be checked
		And the "Java II: 11:00~12:00" checkbox should not be checked
		And I should see todays date within "classes"
		And I should see todays day within "classes"
		And I should not see "06/01/09" within "history"
		And I should not see "06/02/09" within "history"
		And I should not see "11:10~12:00" within "history"
		And I should not see "初級" within "classes"
		And I should not see "13:00~13:30" within "classes"
		And I should have 2 attendances
	When I check "Java I: 11:00~12:00"
		And I press 'reserve'
	Then I should be redirected to the info page of student "kurosawa_akira"
		And the "Java I" checkbox should be checked
		And the "Java II" checkbox should be checked
		And the "Java I: 11:00~12:00" checkbox should be checked
		And I should see 'history'
		And I should see "06/01/09 Java I: 11:10~12:00" within "history"
		And I should see "06/02/09 Java II: 11:10~12:00 "'canceled'
		And I should have 3 attendances
	When I follow 'reserve' within "links"
	Then I should be redirected to the reserve page of student "kurosawa_akira"
		And the "Java I: 11:00~12:00" checkbox should be checked
	Examples:
	|	login						|	password	|
	|	johan_sveholm		|	secret		|
	|	komatsu_aya			|	secret		|