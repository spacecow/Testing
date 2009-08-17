@redirect
Scenario Outline: Playground for staff
	Given the following teacher records
  |	user_name 			|	password	|
  |	johan_sveholm		|	secret		|
  |	komatsu_aya			|	secret		|
  |	thomas_osburg		|	secret		|
	Given the following student record
  |	user_name 			|	password	|
  |	kurosawa_akira	|	secret		|
  Given I am logged in as "<user>" with password "secret"
  When I go to the list of klasses
  Then I should be on the list of klasses
  When I go to the list of template klasses
  Then I should be on the list of template klasses
  When I go to the list of courses
  Then I should be on the list of courses
  When I go to the list of course times
  Then I should be on the list of course times
  When I go to the list of classrooms
  Then I should be on the list of classrooms
  When I go to the list of people
  Then I should be on the list of people
  When I go to the list of students
  Then I should be on the list of people
  When I go to the list of teachers
  Then I should be on the list of people
  Examples:
  | user 						|
  | johan_sveholm 	|
  |	komatsu_aya			|
  |	thomas_osburg		|

Scenario Outline: Redirections for regular users
	Given the following student records
  |	user_name 			|	password	|
  |	kurosawa_akira	|	secret		|
  |	koda_kumiko			|	secret		|
  Given I am logged in as "<user>" with password "secret"
  When I go to the list of klasses
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of template klasses
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of courses
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of course times
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of classrooms
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of people
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of students
  Then I should be redirected to the reserve page of student "<user>"
  When I go to the list of teachers
  Then I should be redirected to the reserve page of student "<user>"
  Examples:
  | user 						|
  |	kurosawa_akira	|
  |	koda_kumiko			|

Scenario Outline: Staff admin can see individual user's pages
	Given the following teacher records
  |	user_name 			|	password	|
  |	johan_sveholm		|	secret		|
  |	komatsu_aya			|	secret		|
	Given the following student records
	|	id	|	user_name 			|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	|	2		|	koda_kumiko			|	secret		|	神田					|	來未子				|
	Given I am logged in as "<user>" with password "secret"
	When I go to the student <no> course page
	Then I should see the "student" page of "<name>"
	When I go to the student <no> reserve page
	Then I should see the "reserve" page of "<name>"
	When I go to the student <no> info page
	Then I should see the "info" page of "<name>"
	Examples:
	|	user					| no	|	name				|
	|	johan_sveholm	|	1		|	黒澤 明			|
	|	komatsu_aya		|	2		|	神田 來未子	|

Scenario Outline: Staff viewer can only see other user's info Page
	Given the following teacher record
  |	user_name 			|	password	|
  |	thomas_osburg		|	secret		|	
	Given the following student records
	|	id	|	user_name 			|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	|	2		|	koda_kumiko			|	secret		|	神田					|	來未子				|
	Given I am logged in as "thomas_osburg" with password "secret"
	When I go to the student <no> reserve page
	Then I should be retransfered to the "info" page of "<name>"
	When I go to the student <no> course page
	Then I should be retransfered to the "info" page of "<name>"
	When I go to the student <no> info page
	Then I should see the "info" page of "<name>"
	Examples:
	| no	|	name				|
	|	1		|	黒澤 明			|
	|	2		|	神田 來未子	|
	
Scenario Outline: Regular Users cannot see other student's Mafumafu Page
	Given the following teacher records
	|	user_name 			|	password	|	family_name	|	first_name	|
	|	prince_philip		|	secret		|	Prince			|	Philip			|
	|	chris_the_man		|	secret		|	The Man			|	Chris				|
	Given the following student records
	|	id	|	user_name 			|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	|	2		|	koda_kumiko			|	secret		|	神田					|	來未子				|
	Given I am logged in as "<user>" with password "secret"
	When I go to the reserve page of student "<student>"
	Then I should be redirected to the <default> page of <status> "<user>"
	And I should see 'people.error.unauthorized_access'
	When I go to the course page of student "<student>"
	Then I should be redirected to the <default> page of <status> "<user>"
	And I should see 'people.error.unauthorized_access'
	When I go to the info page of student "<student>"
	Then I should be redirected to the <default> page of <status> "<user>"
	And I should see 'people.error.unauthorized_access'
	Examples:
	|	user						|	student					| default	|	status 	|
	|	koda_kumiko			|	kurosawa_akira	| reserve	|	student	|
	|	kurosawa_akira	|	koda_kumiko			| reserve	| student	|
	|	chris_the_man		|	kurosawa_akira	| info		|	teacher	|
	|	chris_the_man		|	koda_kumiko			| info		|	teacher	|
	|	prince_philip		|	kurosawa_akira	| info		|	teacher	|
	|	prince_philip		|	koda_kumiko			| info		|	teacher	|
	
Scenario Outline: Regular Students cannot see all of their Mafumafu Pages
	Given the following student records
	|	id	|	user_name 			|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	|	2		|	koda_kumiko			|	secret		|	神田					|	來未子				|
	Given I am logged in as "<user>" with password "secret"
	When I go to the student <no> reserve page
	Then I should not see 'people.error.unauthorized_access'
	When I go to the student <no> course page
	Then I should be retransfered to the "reserve" page of "<name>"
	And I should see 'people.error.unauthorized_access'
	When I go to the student <no> info page
	Then I should not see 'people.error.unauthorized_access'
	Examples:
	|	user						|	no	| name 				|
	|	kurosawa_akira	|	1		| 黒澤 明			|
	|	koda_kumiko			|	2		| 神田 來未子	|
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	