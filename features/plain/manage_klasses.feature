@klasses	
	
Scenario: 
	Given I have courses titled "入門 I, 入門 II"
  Given the following teacher record
  |	id	|	user_name     | password |
  | 1		|	johan_sveholm | secret   |
  Given the following student record
  |	id	|	user_name				|	password	|	first_name	|	family_name	|
  |	1		|	kurosawa_akira	|	secret		|	Akira				|	Kurosawa		|
  |	2		|	koda_kumiko			|	secret		|	Kumiko			|	Koda				|
  |	3		|	asae_mao				|	secret		|	Mao					|	Adae				|    
	Given the following attendance record
	| klass_id	|	student_id	|
	|	1					|	1						|
	|	2					|	2						|
	|	3					|	3						|
  Given the following klass record
	|	id	|	course	|	start_time	|	end_time	|
	|	1		|	入門 I		|	13:00				| 15:00			|
	|	2		|	入門 I 	|	13:00				| 15:00			|
	|	3		|	入門 II 	|	13:00				| 15:00			|
	When I go to the list of klasses
	And I am logged in as "johan_sveholm" with password "secret"
	Then I should see "Kurosawa Akira" within "klass_1"
	And I should see "Koda Kumiko" within "klass_1"
	And I should not see "Adae Mao" within "klass_1"
	And I should see "Kurosawa Akira" within "klass_2"
	And I should see "Koda Kumiko" within "klass_2"
	And I should not see "Adae Mao" within "klass_2"	
	And I should not see "Kurosawa Akira" within "klass_3"
	And I should not see "Koda Kumiko" within "klass_3"
	And I should see "Adae Mao" within "klass_3"		
	
Scenario Outline: Chosen Teachers and Classrooms cannot be chosen again at the same Time
	Given I have courses titled "入門 I, 入門 II"
	Given I have the following classroom records
	|	id	|	name		|
	|	1		|	room_1	|
	|	2		|	room_2	|
	|	3		|	room_3	|
  Given the following teacher record
  |	id	|	user_name     | password |	first_name	|	family_name	|
  | 1		|	johan_sveholm | secret   |	Johan				|	Sveholm			|
  | 2		|	ali_bumba 		| secret   |	Ali					|	Bumba				|
  | 3		|	k1_loser 			| secret   |	K1					|	Loser				|
  Given the following klass record
	|	id	|	course	|	start_time	|	end_time	| teacher_id	| classroom_id	|
	|	1		|	入門 I		|	13:00				| 15:00			|	1						|	1							|
	|	2		|	入門 II	|	14:00				| 16:00			|	2						|	2							|
  Given the following template klass record
	|	id	|	course	|	start_time	|	end_time	| teacher_id	| classroom_id	|
	|	1		|	入門 I		|	13:00				| 15:00			|	1						|	1							|
	|	2		|	入門 II	|	14:00				| 16:00			|	2						|	2							|
	Given teacher "johan_sveholm" has course "入門 I"
	  And teacher "ali_bumba" has courses "入門 I, 入門 II"
	  And teacher "k1_loser" has course "入門 II"
	When I go to the list of <object>es
		And I am logged in as "johan_sveholm" with password "secret"
	Then I should be redirected to the list of <object>es
		And I should see "Sveholm Johan" within "<object>_1"
		And I should not see "Bumba Ali" within "<object>_1"
		And I should not see "Loser K1" within "<object>_1"
		And I should see "room_1" within "<object>_1"
		And I should not see "room_2" within "<object>_1"
		And I should see "room_3" within "<object>_1"
		And I should not see "Sveholm Johan" within "<object>_2"
		And I should see "Bumba Ali" within "<object>_2"
		And I should see "Loser K1" within "<object>_2"
		And I should not see "room_1" within "<object>_2"
		And I should see "room_2" within "<object>_2"
		And I should see "room_3" within "<object>_2"		
	Examples:
		| object 					|
		|	klass						|
		|	template_klass	|