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
  | asada_mao				|	secret		|	Mao					|	Asada				|
  |	koda_kumiko			|	secret		|	Kumiko			|	Koda				|
	And students "kurosawa_akira, asada_mao, koda_kumiko" have class "1"
	And students "kurosawa_akira, koda_kumiko" have class "1" chosen
	And students "kurosawa_akira, asada_mao, koda_kumiko" should have 1 class
	And class "1" should have 3 students

Scenario Outline: Admin see non-chosen attendances
When I am logged in as "<user>"
Then I should see "Kurosawa Akira" within "klass_1"
Examples:
| user					|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario: Observer dont see non-chosen attendances
When I am logged in as "thomas_osburg"
Then I should not see "Asada Mao" within "klass_1"

Scenario Outline: Regular users get redirected
When I am logged in as "<user>"
Then I should be redirected to the <default> page of <status> "<user>"
Examples:
|	user						|	default	|	status 	|
|	kurosawa_akira	|	reserve |	student	|
|	prince_philip		|	info		|	teacher	|

Scenario: List students on the class edit page
Given I am logged in as "johan_sveholm"	
When I follow 'edit' within "klass_1"
Then I should see "Kurosawa Akira" within "students"
	And I should not see "Asada Mao" within "students"
	And I should see "Koda Kumiko" within "students"

Scenario: Info page
Given I am logged in as "johan_sveholm"	
	And I follow 'edit' within "klass_1"
When I follow 'info' within "kurosawa_akira"
Then I should see 'attendances.title' within "form"

Scenario: Edit page
Given I am logged in as "johan_sveholm"	
	And I follow 'edit' within "klass_1"
When I follow 'edit' within "kurosawa_akira"
Then I should see 'attendances.editing' within "form"

Scenario: Cancel
Given I am logged in as "johan_sveholm"	
	And I follow 'edit' within "klass_1"
When I follow 'cancel' within "koda_kumiko"
Then I should see 'cancel' within "kurosawa_akira"
	And I should see 'uncancel' within "koda_kumiko"
When I follow 'uncancel' within "koda_kumiko"
Then I should see 'cancel' within "kurosawa_akira"
	And I should see 'cancel' within "koda_kumiko"	
	
Scenario: Delete
Given I am logged in as "johan_sveholm"	
	And I follow 'edit' within "klass_1"
When I follow 'delete' within "kurosawa_akira"
Then I should not see "Kurosawa Akira" within "students"
	And I should not see "Asada Mao" within "students"
	And I should see "Koda Kumiko" within "students"
When I follow 'delete' within "koda_kumiko"
Then I should not see "Kurosawa Akira" within "students"
	And I should not see "Asada Mao" within "students"
	And I should not see "Koda Kumiko" within "students"