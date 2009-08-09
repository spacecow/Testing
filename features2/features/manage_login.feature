@login
Scenario Outline: Login Options and Actions
  Given the following teacher record
  |	user_name 		|	password	|	language	|
  |	johan_sveholm	|	secret		|	en				|
  |	komatsu_aya		|	secret		|	en				|
  |	thomas_osburg	|	secret		|	jp				|  
	Given the following student record
  | user_name				|	password	|	family_name	|	first_name	|
  |	kurosawa_akira	|	secret		|	黒澤					|	明						|
	Given I go to the <page>
	When I fill in 'login.user_name' with "<login>"
	And I fill in 'login.password' with "<password>"
	And I press 'login.button'
	Then I should see <action>

  Examples:
    |	page						|	login						|	password	|	action																	|
    |	login page			|	johan_sveholm		|	wrong			|	'login.flash.invalid_user_or_password'	|
    |	login page			|	kurosawa_akira	|	secret		|	"黒澤 明"																|
    |	list of courses	|	johan_sveholm		|	secret		|	'courses.listing'												|
    |	login page			|	johan_sveholm		|	secret		|	todays day															|
    |	login page			|	komatsu_aya			|	secret		|	todays day															|
    |	login page			|	thomas_osburg		|	secret		|	todays day															|

Scenario Outline: Menu Listing
	Given the following teacher records
  |	user_name 			|	password	|
  |	johan_sveholm		|	secret		|
  |	komatsu_aya			|	secret		|
  |	thomas_osburg		|	secret		|
	Given the following student record
  |	user_name 			|	password	|
  |	kurosawa_akira	|	secret		|
  When I am logged in as "<user>" with password "secret"
  Then I should <staff_menu> 'people.title' within "banner"
  And I should <staff_menu> 'klasses.title' within "banner"
  And I should see 'mymafumafu.title' within "banner"
  And I should <johan_menu> 'documentation.title' within "banner"
  
  Examples:
  | user 						|	staff_menu	|	johan_menu	|
  | johan_sveholm 	|	see					| see					|
  |	komatsu_aya			|	see					| not see			|
  |	thomas_osburg		|	see					| not see			|
  |	kurosawa_akira	|	not see			| not see			|

Scenario: Redirection
  Given the following teacher record
  |	user_name 		|	password	|
  |	johan_sveholm	|	secret		|
  Given I am logged in as "johan_sveholm" with password "secret"
  When I am on the list of template klasses
  And I select "Monday" from "template_day"

Scenario: Before accessing pages you have to be logged in
	Given the following student record
	|	id	| user_name				|	password	|	family_name	|	first_name	|
	|	1		|	kurosawa_akira	|	secret		|	黒澤					|	明						|
	When I go to the list of people
	Then I should be redirected to the login page   
	When I go to the list of teachers
	Then I should be redirected to the login page   
	When I go to the list of students
	Then I should be redirected to the login page   
	When I go to the list of klasses
	Then I should be redirected to the login page   
	When I go to the list of template klasses
	Then I should be redirected to the login page   
	When I go to the list of courses
	Then I should be redirected to the login page   
	When I go to the list of course times
	Then I should be redirected to the login page   
	When I go to the list of classrooms
	Then I should be redirected to the login page
	When I go to student 1 course page
	Then I should be redirected to the login page	