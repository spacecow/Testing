@teachers
Scenario Outline: Regular teacher has no courses and no classes
	Given the following teacher records
	|	user_name 		|	password	|	family_name	|	first_name	|
	|	prince_philip	|	secret		|	Prince			|	Philip			|
	|	chris_the_man	|	secret		|	The Man			|	Chris				|
  Given the following teacher records
  |	user_name 		|	password	|
  |	johan_sveholm	|	secret		|
	|	komatsu_aya		|	secret		|
	|	thomas_osburg	|	secret		|
	Given I have no courses
		And I have no classes
	When I am logged in as "<user>" with password "secret"
		And I go to the info page of teacher "<name>"
	Then I should not see 'courses.title' within "courses"
		And I should not see 'klasses.title' within "klasses"
	Examples:
	|	user					|	name					|
	|	prince_philip	|	prince_philip	|
	|	chris_the_man	|	chris_the_man	|
	| johan_sveholm	|	prince_philip	|
	| johan_sveholm	|	chris_the_man	|
	| komatsu_aya		|	prince_philip	|
	| komatsu_aya		|	chris_the_man	|
	| thomas_osburg	|	prince_philip	|
	| thomas_osburg	|	chris_the_man	|
	
Scenario Outline: Regular teacher has classes and courses
	Given the following teacher records
	|	id	|	user_name 		|	password	|	family_name	|	first_name	|
	|	1		|	prince_philip	|	secret		|	Prince			|	Philip			|
	|	2		|	chris_the_man	|	secret		|	The Man			|	Chris				|
	Given the following course record
	| id 	| name	|
	|	1		|	Java	|
	Given the following class records
	| teacher_id	| course_id | start_time	|	end_time	|
	|	1						|	1					|	11:00				|	12:00			|
	|	2						|	1					|	11:00				|	12:00			|
	Given the following teaching record
	| course_id	|	teacher_id	|
	|	1					|	2						|
	When I am logged in as "<user>" with password "secret"
		And I go to the info page of teacher "<name>"
	Then I should see 'klasses.title' within "klasses"
		And I should see todays day
		And I should see todays date
		And I should see "Java: 11:00~12:00"
		And teacher "<user>" should have 1 klass
		And I should not see 'courses.title' within "courses"
		And teacher "<user>" should have <no> courses
	Examples:
	|	user					|	name					| no	|
	|	prince_philip	|	prince_philip	|	0		|
	|	chris_the_man	|	chris_the_man	|	1		|

Scenario Outline: Regular teacher (visited by admin) has classes and courses
  Given the following teacher records
  |	id	| user_name 		|	password	|
  |	1		|	prince_philip	|	secret		|
  |	2		|	chris_the_man	|	secret		|
  |	3		|	johan_sveholm	|	secret		|
	|	4		|	komatsu_aya		|	secret		|
	|	5		|	thomas_osburg	|	secret		|
	Given the following course record
	| id 	| name	|
	|	1		|	Java	|
	Given the following class records
	| teacher_id	| course_id | start_time	|	end_time	|
	|	1						|	1					|	11:00				|	12:00			|
	|	2						|	1					|	11:00				|	12:00			|
	Given the following teaching record
	| course_id	|	teacher_id	|
	|	1					|	2						|
	When I am logged in as "<user>" with password "secret"
		And I go to the info page of teacher "<name>"
	Then I should see 'klasses.title' within "klasses"
		And I should see todays day
		And I should see todays date
		And I should see "Java: 11:00~12:00"
		And teacher "<name>" should have 1 klass
		And I should <view> 'courses.title' within "courses"
		And teacher "<name>" should have <no> courses
	Examples:
	|	user					|	name					| view		|	no	|
	|	johan_sveholm	|	prince_philip	|	not see	|	0		|
	|	johan_sveholm	|	chris_the_man	|	see			|	1		|
	|	komatsu_aya		|	prince_philip	|	not see	|	0		|
	|	komatsu_aya		|	chris_the_man	|	see			|	1		|
	|	thomas_osburg	|	prince_philip	|	not see	|	0		|
	|	thomas_osburg	|	chris_the_man	|	see			|	1		|

@teaching
Scenario Outline: Regular teacher has classes (and history)
  Given the following teacher records
  |	id	| user_name 		|	password	|
  |	1		|	prince_philip	|	secret		|
  |	2		|	chris_the_man	|	secret		|
  |	3		|	johan_sveholm	|	secret		|
	|	4		|	komatsu_aya		|	secret		|
	|	5		|	thomas_osburg	|	secret		|
	Given the following course record
	| id 	| name		|
	|	1		|	Java		|
	|	2		| Fortran	|
	Given the following class records
	| teacher_id	| course_id | start_time	|	end_time	| date					|
	|	1						|	1					|	11:00				|	12:00			| current date	|
	|	2						|	1					|	11:00				|	12:00			| current date	|
	|	2						|	2					|	15:00				|	16:00			| 06/01/09			|
	Given the following teaching record
	| course_id	|	teacher_id	|
	|	1					|	2						|
	When I am logged in as "<user>" with password "secret"
		And I go to the info page of teacher "<name>"
	Then I should see 'klasses.title' within "klasses"
		And I should see todays day
		And I should see todays date
		And I should see "Java: 11:00~12:00"
		And teacher "<name>" should have <no_klasses>
		And I should <view> 'history' within "history"
		And I should <view> "06/01/09: Monday" within "history"
		And I should <view> "Fortran: 15:00~16:00" within "history"
	Examples:
	|	user					|	name					| view		|	no_klasses	|
	|	johan_sveholm	|	prince_philip	|	not see	|	1 klass			|
	|	johan_sveholm	|	chris_the_man	|	see			|	2 klasses		|
	|	komatsu_aya		|	prince_philip	|	not see	|	1 klass			|
	|	komatsu_aya		|	chris_the_man	|	see			|	2 klasses		|
	|	thomas_osburg	|	prince_philip	|	not see	|	1 klass			|
	|	thomas_osburg	|	chris_the_man	|	see			|	2 klasses		|
	
Scenario Outline: Links on teacher's Info Page
	Given the following teacher records
	|	id	|	user_name 		|	password	|	family_name	|	first_name	|
	|	1		|	prince_philip	|	secret		|	Prince			|	Philip			|
  |	2		|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
	|	3		|	komatsu_aya		|	secret		| 小松				|	あや				|
	Given I am logged in as "<user>" with password "secret"
		And I go to the info page of teacher "prince_philip"
	When I follow 'courses.title' within "links"
	Then I should see the "teacher" page of "Prince Philip"
	Examples:
	|	user					|
	|	johan_sveholm	|
	| komatsu_aya		|

Scenario Outline: No links on teacher's Info Page
	Given the following teacher records
	|	id	|	user_name 		|	password	|	family_name	|	first_name	|
	|	1		|	prince_philip	|	secret		|	Prince			|	Philip			|
  |	2		|	thomas_osburg	|	secret		|	Osburg			|	Thomas			|
	Given I am logged in as "<user>" with password "secret"
	When I go to the info page of teacher "prince_philip"
	Then I should not see 'courses.title' within "links"
	Examples:
	|	user					|
	|	prince_philip	|
	| thomas_osburg	|

Scenario Outline: Regular Users cannot see other teacher's Mafumafu Page
	Given the following teacher records
	|	id	|	user_name 			|	password	|	family_name	|	first_name	|
	|	1		|	prince_philip		|	secret		|	Prince			|	Philip			|
	|	2		|	chris_the_man		|	secret		|	The Man			|	Chris				|
	Given the following student records
	|	user_name 			|	password	|	family_name	|	first_name	|
	|	kurosawa_akira	|	secret		|	黒澤					|	明				|
	|	koda_kumiko			|	secret		|	神田					|	來未子		|
	Given I am logged in as "<user>" with password "secret"
	When I go to the teacher <no> info page
	Then I should be retransfered to the "<default>" page of "<name>"
		And I should see 'people.error.unauthorized_access'
	Examples:
	|	user						|	no	| default	|	name 					|
	|	chris_the_man		|	1		| info		|	The Man Chris	|
	|	prince_philip		|	2		| info		|	Prince Philip	|	
	| kurosawa_akira	|	1		|	reserve	|	黒澤 明				|
	| kurosawa_akira	|	2		|	reserve	|	黒澤 明				|
	| koda_kumiko			|	1		|	reserve	|	神田 來未子		|
	| koda_kumiko			|	2		|	reserve	|	神田 來未子		|
	
Scenario Outline: Regular Teachers cannot see all of their Mafumafu Pages
	Given the following teacher records
	|	id	|	user_name 			|	password	|	family_name	|	first_name	|
	|	1		|	prince_philip		|	secret		|	Prince			|	Philip			|
	|	2		|	chris_the_man		|	secret		|	The Man			|	Chris				|
	Given I am logged in as "<user>" with password "secret"
	When I go to the teacher <no> info page
	Then I should not see 'people.error.unauthorized_access'
	Examples:
	|	user						|	no	|	name 					|
	|	prince_philip		|	1		|	Prince Philip	|
	|	chris_the_man		|	2		|	The Man Chris	|		


































