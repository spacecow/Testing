@mafumafu
Scenario Outline: Users that can reach My Mafumafu Course Page
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	ja				|
	|	komatsu_aya		|	secret		| en				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given I am logged in as "<login>" with password "secret"
	When I go to student 1 course page
	Then I should see the "student" page of "黒澤 明"
	And I should see 'info' within "links"
	And I should see 'reserve' within "links"	
	Examples:
	|	login						|
	|	johan_sveholm		|
	|	komatsu_aya			|
	
Scenario Outline: Users that cannot reach My Mafumafu Course Page
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	thomas_osburg	|	secret		|	en				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	|	2		|	koda_kumiko			|	secret		|	神田					|	來未子				|	
	Given I am logged in as "<login>" with password "<password>"
	When I go to student 1 course page
	Then I should see <view>
	Examples:
	|	login						|	password	|	view										|
	|	thomas_osburg		|	secret		|	'info'" - 黒澤 明"				|
	|	kurosawa_akira	|	secret		|	'reserve'" - 黒澤 明"		|
	| koda_kumiko			|	secret		|	'reserve'" - 神田 來未子"	|

Scenario Outline: Choose courses
	Given I have courses titled "入門 I, 入門 II, 初級 I"
	Given the following teacher records
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	en				|
	|	komatsu_aya		|	secret		| ja				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	| language	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|	en				|
	Given I am logged in as "<login>" with password "<password>"
	And I go to student 1 course page
	And the "入門 I" checkbox should not be checked
	And the "入門 II" checkbox should not be checked
	And the "初級 I" checkbox should not be checked
	And I check "入門 I"
	And I check "入門 II"
	And I press 'update'
	Then I should see the "reserve" page of "黒澤 明"
	And the "入門 I" checkbox should be checked
	And the "入門 II" checkbox should be checked	
	When I follow 'courses.title' within "links"
	Then I should see the "student" page of "黒澤 明"
	And the "入門 I" checkbox should be checked
	And the "入門 II" checkbox should be checked	
	
	Examples:
	|	login						|	password	|
	|	johan_sveholm		|	secret		|
	|	komatsu_aya			|	secret		|

Scenario Outline: Users that can reach My Mafumafu Reserve Page
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	ja				|
	|	komatsu_aya		|	secret		| en				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given I am logged in as "<login>" with password "<password>"
	When I go to student 1 reserve page
	Then I should see 'reserve'" - 黒澤 明"
	And I should see 'info' within "links"
	And I should <link> 'courses.title' within "links"	
	Examples:
	|	login						|	password	| link		|
	|	johan_sveholm		|	secret		|	see			|
	|	komatsu_aya			|	secret		|	see			|
	| kurosawa_akira	|	secret		|	not see	|

Scenario Outline: Users that cannot reach My Mafumafu Reserve Page
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	thomas_osburg	|	secret		|	en				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	|	2		|	koda_kumiko			|	secret		|	神田					|	來未子				|	
	Given I am logged in as "<login>" with password "<password>"
	When I go to student 1 reserve page
	Then I should see <view>
	Examples:
	|	login						|	password	|	view										|
	|	thomas_osburg		|	secret		|	'info'" - 黒澤 明"				|
	| koda_kumiko			|	secret		|	'reserve'" - 神田 來未子"	|

@mafumafu
Scenario Outline: Admins Reserve Classes
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	en				|
	|	komatsu_aya		|	secret		| ja				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given the following course records
	|	id	|	name		|
	|	1		|	入門 I		|
	|	2		|	入門 II	|
	|	3		|	初級 I		|
	Given the following klass record
	|	id	| course	| date 					|	start_time	|	end_time	|
	|	1		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	2		|	入門 II	|	current date	| 11:00				|	12:00			|
	|	3		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	4		|	入門 I		|	06/01/09			| 11:10				|	12:00			|
	|	5		|	入門 II	|	06/02/09			| 11:10				|	12:00			|
	|	6		|	初級 I		|	current date	| 13:00				|	13:30			|
	Given the following courses student records
	|	course_id	|	student_id	|
	|	1					|	1						|
	|	2					|	1						|
	Given the following attendance record
	|	klass_id	|	student_id	| cancel	|
	|	4					|	1						|	0				|
	|	5					|	1						|	1				|
	Given I am logged in as "<login>" with password "<password>"
	And I go to student 1 reserve page
	And the "入門 I" checkbox should be checked
	And the "入門 II" checkbox should be checked
	And the "入門 I: 11:00~12:00" checkbox should not be checked
	And the "入門 II: 11:00~12:00" checkbox should not be checked
	And I should see todays date
	And I should see todays day
	And I should not see "06/01/09"	
	And I should not see "06/02/09"	
	And I should not see "11:10~12:00"
	And I should not see "初級"
	And I should not see "13:00~13:30"
	And I should have 2 attendances
	When I check "入門 I: 11:00~12:00"
	And I press 'reserve'
	Then I should see 'info'" - 黒澤 明"
	And the "入門 I" checkbox should be checked
	And the "入門 II" checkbox should be checked
	And the "入門 I: 11:00~12:00" checkbox should be checked
	And I should see 'history'
	And I should see "06/01/09 入門 I: 11:10~12:00"
	And I should see "06/02/09 入門 II: 11:10~12:00 "'canceled'
	And I should have 3 attendances
	When I follow 'reserve' within "links"
	Then I should see 'reserve'" - 黒澤 明"
	And the "入門 I: 11:00~12:00" checkbox should be checked
	Examples:
	|	login						|	password	|
	|	johan_sveholm		|	secret		|
	|	komatsu_aya			|	secret		|

Scenario: User Reserves Classes
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given the following course records
	|	id	|	name		|
	|	1		|	入門 I		|
	|	2		|	入門 II	|
	|	3		|	初級 I		|
	Given the following klass record
	|	id	| course	| date 					|	start_time	|	end_time	|
	|	1		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	2		|	入門 II	|	current date	| 11:00				|	12:00			|
	|	3		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	4		|	入門 I		|	06/01/09			| 11:10				|	12:00			|
	|	5		|	入門 II	|	06/02/09			| 11:10				|	12:00			|
	|	6		|	初級 I		|	current date	| 13:00				|	13:30			|
	Given the following courses student records
	|	course_id	|	student_id	|
	|	1					|	1						|
	|	2					|	1						|
	Given the following attendance record
	|	klass_id	|	student_id	| cancel	|
	|	4					|	1						|	0				|
	|	5					|	1						|	1				|
	Given I am logged in as "kurosawa_akira" with password "secret"
	And I go to student 1 reserve page
	And the "入門 I: 11:00~12:00" checkbox should not be checked
	And the "入門 II: 11:00~12:00" checkbox should not be checked
	And I should see todays date
	And I should see todays day
	And I should not see "06/01/09"	
	And I should not see "06/02/09"	
	And I should not see "11:10~12:00"
	And I should not see "初級"
	And I should not see "13:00~13:30"
	When I check "入門 I: 11:00~12:00"
	And I press 'reserve'
	Then I should see 'info'" - 黒澤 明"
	And I should see "06/01/09 入門 I: 11:10~12:00"
	And I should not see "06/02/09 入門 II: 11:10~12:00"
	When I follow 'reserve' within "links"
	Then I should see 'reserve'" - 黒澤 明"
	And the "入門 I: 11:00~12:00" checkbox should be checked	

Scenario Outline: Admins Cancel Classes
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	en				|
	|	komatsu_aya		|	secret		| ja				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given the following course records
	|	id	|	name		|
	|	1		|	入門 I		|
	|	2		|	入門 II	|
	|	3		|	初級 I		|
	Given the following klass record
	|	id	| course	| date 					|	start_time	|	end_time	|
	|	1		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	2		|	入門 II	|	current date	| 11:00				|	12:00			|
	|	3		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	4		|	入門 I		|	06/01/09			| 11:10				|	12:00			|
	|	5		|	入門 II	|	06/02/09			| 11:10				|	12:00			|
	|	6		|	初級 I		|	current date	| 13:00				|	13:30			|
	Given the following courses student records
	|	course_id	|	student_id	|
	|	1					|	1						|
	|	2					|	1						|
	Given the following attendance record
	|	klass_id	|	student_id	| cancel	|
	|	1					|	1						|	0				|
	|	4					|	1						|	0				|
	|	5					|	1						|	1				|
	Given I am logged in as "<login>" with password "<password>"
	And I go to student 1 reserve page
	And I should have 3 attendances
	When I check 'cancel'
	And I press 'reserve'
	Then I should see 'info'" - 黒澤 明"
	And the "入門 I: 11:00~12:00 "'canceled' checkbox should be checked
	And I should have 3 attendances
	When I follow 'reserve' within "links"
	Then I should see 'reserve'" - 黒澤 明"
	And the 'cancel' checkbox should be checked	
	Examples:
	|	login						|	password	|
	|	johan_sveholm		|	secret		|
	|	komatsu_aya			|	secret		|

Scenario Outline: Admins Remove Classes
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	en				|
	|	komatsu_aya		|	secret		| ja				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given the following course records
	|	id	|	name		|
	|	1		|	入門 I		|
	|	2		|	入門 II	|
	|	3		|	初級 I		|
	Given the following klass record
	|	id	| course	| date 					|	start_time	|	end_time	|
	|	1		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	2		|	入門 II	|	current date	| 11:00				|	12:00			|
	|	3		|	入門 I		|	current date	| 11:00				|	12:00			|
	|	4		|	入門 I		|	06/01/09			| 11:10				|	12:00			|
	|	5		|	入門 II	|	06/02/09			| 11:10				|	12:00			|
	|	6		|	初級 I		|	current date	| 13:00				|	13:30			|
	Given the following courses student records
	|	course_id	|	student_id	|
	|	1					|	1						|
	|	2					|	1						|
	Given the following attendance record
	|	klass_id	|	student_id	| cancel	|
	|	1					|	1						|	1				|
	|	2					|	1						|	0				|
	|	4					|	1						|	0				|
	|	5					|	1						|	1				|
	Given I am logged in as "<login>" with password "<password>"
	And I go to student 1 reserve page
	And I should have 4 attendances
	When I uncheck "入門 I: 11:00~12:00"
	And I press 'reserve'
	Then I should see 'info'" - 黒澤 明"
	And I should not see "入門 I: 11:00~12:00"
	And I should see "入門 II: 11:00~12:00"
	And I should have 3 attendances
	When I follow 'reserve' within "links"
	Then I should see 'reserve'" - 黒澤 明"
	And the "入門 I: 11:00~12:00" checkbox should not be checked	
	And the "入門 II: 11:00~12:00" checkbox should be checked	
	Examples:
	|	login						|	password	|
	|	johan_sveholm		|	secret		|
	|	komatsu_aya			|	secret		|

Scenario Outline: My Mafumafu Info Page
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	en				|
	|	komatsu_aya		|	secret		| ja				|
	| thomas_osburg | secret		|	en				|
	Given the following student record
	| id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given the following course records
	|	id	|	name		|
	|	1		|	入門 I	|
	|	2		|	入門 II	|
	|	3		|	初級 I	|
	Given the following klass record
	|	id	| course	| date 					|	start_time	|	end_time	|
	|	1		|	入門 I	|	current date	| 11:00				|	12:00			|
	|	2		|	入門 II	|	current date	| 11:00				|	12:00			|
	|	3		|	入門 I	|	current date	| 11:00				|	12:00			|
	|	4		|	入門 I	|	06/01/09			| 11:10				|	12:00			|
	|	5		|	入門 II	|	06/02/09			| 11:10				|	12:00			|
	|	6		|	初級 I	|	current date	| 13:00				|	13:30			|
	Given the following courses student records
	|	course_id	|	student_id	|
	|	1					|	1						|
	|	2					|	1						|
	Given the following attendance record
	|	klass_id	|	student_id	| cancel	|
	|	1					|	1						|	1				|
	|	2					|	1						|	0				|
	|	4					|	1						|	0				|
	|	5					|	1						|	1				|
	Given I am logged in as "<login>" with password "secret"
	When I go to student 1 reserve page
	And I <extra>
	Then I should see 'info'" - 黒澤 明"
	And I should <cancel> "入門 I: 11:00~12:00 "'canceled'
	And the "入門 II: 11:00~12:00" checkbox should be checked
	And I should see 'history'
	And I should see "06/01/09 入門 I: 11:10~12:00"
	And I should <cancel> "06/02/09 入門 II: 11:10~12:00 "'canceled'	
	And I should <link> 'courses.title' within "links"	
	And I should <link2> 'reserve' within "links"
	Examples:
	|	login						|	extra													| link		| link2		| cancel	|
	|	johan_sveholm		|	follow 'info' within "links"	|	see			|	see			|	see			|
	|	komatsu_aya			|	follow 'info' within "links"	|	see			|	see			|	see			|
	| thomas_osburg		|	should see 'courses.title'		|	not see	|	not see	|	see			|
	| kurosawa_akira	|	follow 'info' within "links"	|	not see	|	see			|	not see	|
















