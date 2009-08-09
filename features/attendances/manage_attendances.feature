@attendances
Background:
Given I have courses titled "Java I, Java II, Java III, Ruby I"
	And I have teacher "johan_sveholm, komatsu_aya, thomas_osburg, prince_philip"
  And the following klass record
  |	id	|	course	|
  |	1		|	Java I	|
  And the following student record
  |	user_name				|	password	|	first_name	|	family_name	|
  |	kurosawa_akira	|	secret		|	Akira				|	Kurosawa		|
	And that student "kurosawa_akira" has class "1"

Scenario Outline: Admin see non-chosen attendances
When I am logged in as "<user>"
Then I should see "Kurosawa Akira" within "klass_1"
Examples:
| user					|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario: Observer dont see non-chosen attendances
When I am logged in as "thomas_osburg"
Then I should not see "Kurosawa Akira" within "klass_1"

Scenario Outline: Regular users get redirected
When I am logged in as "<user>"
Then I should be redirected to the <default> page of <status> "<user>"
Examples:
|	user						|	default	|	status 	|
|	kurosawa_akira	|	reserve |	student	|
|	prince_philip		|	info		|	teacher	|