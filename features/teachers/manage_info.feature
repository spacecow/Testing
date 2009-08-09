@info_teachers

Background:
Given the following teacher records
|	user_name 		|	password	|
|	prince_philip	|	secret		|
|	chris_the_man	|	secret		|
|	johan_sveholm	|	secret		|
|	komatsu_aya		|	secret		|
|	thomas_osburg	|	secret		|
Given the following student record
|	user_name				|	password	|
|	kurosawa_akira	|	secret		|

Scenario Outline: Teacher has no courses and no classes
Given I have no courses
	And I have no classes
When I am logged in as "<user>" with password "secret"
	And I go to the info page of teacher "<name>"
Then I should not see 'courses.title' within "courses"
	And I should not see 'klasses.title' within "klasses"
	And I should not see 'history' within "history"
Examples:
|	user					|	name					|
|	prince_philip	|	prince_philip	|
| johan_sveholm	|	prince_philip	|
| komatsu_aya		|	prince_philip	|
| thomas_osburg	|	prince_philip	|

Scenario Outline: Teacher has courses
Given I have courses titled "Java, Prolog"
	And that teacher "prince_philip" has course "Prolog"
When I am logged in as "<user>" with password "secret"
	And I go to the info page of teacher "<name>"
Then I should <view> 'courses.title' within "courses"
	And I should <view> "Prolog" within "courses"
Examples:
|	user					|	name					| view		|
|	prince_philip	|	prince_philip	|	not see	|
|	johan_sveholm	|	prince_philip	|	see			|
|	komatsu_aya		|	prince_philip	|	see			|
|	thomas_osburg	|	prince_philip	|	see			|

Scenario Outline: Regular teacher has classes and courses
Given I have courses titled "Java"
	And that teacher "chris_the_man" has course "Java"
	And that teacher "chris_the_man" has class "Java"
When I am logged in as "<user>" with password "secret"
	And I go to the info page of teacher "<name>"
Then I should see 'klasses.title' within "klasses"
	And I should see todays day within "klasses"
	And I should see todays date within "klasses"
	And I should see "Java" within "klasses"
	And I should not see 'history' within "history"
Examples:
|	user					|	name					|
|	chris_the_man	|	chris_the_man	|
|	johan_sveholm	|	chris_the_man	|
|	komatsu_aya		|	chris_the_man	|
|	thomas_osburg	|	chris_the_man	|

Scenario Outline: Regular teacher has history
Given I have courses titled "Java"
	And that teacher "chris_the_man" has course "Java"
	And that teacher "chris_the_man" had class "Java" yesterday
When I am logged in as "<user>" with password "secret"
	And I go to the info page of teacher "<name>"
Then I should see 'klasses.title' within "klasses"
	And I should not see "Java" within "klasses"
	And I should see 'history' within "history"
	And I should see "Java" within "history"
	And I should see yesterdays day within "history"
	And I should see yesterdays date within "history"

Examples:
|	user					|	name					|
|	chris_the_man	|	chris_the_man	|
|	johan_sveholm	|	chris_the_man	|
|	komatsu_aya		|	chris_the_man	|
|	thomas_osburg	|	chris_the_man	|

Scenario Outline: Admins see links on teacher's Info Page
Given I am logged in as "<user>" with password "secret"
	And I go to the info page of teacher "prince_philip"
When I follow 'courses.title' within "links"
Then I should be on the course page of teacher "prince_philip"
Examples:
|	user					|
|	johan_sveholm	|
| komatsu_aya		|

Scenario Outline: Other than admins see no links on teacher's Info Page
Given I am logged in as "<user>" with password "secret"
When I go to the info page of teacher "prince_philip"
Then I should not see 'courses.title' within "links"
Examples:
|	user					|
|	prince_philip	|
| thomas_osburg	|

Scenario Outline: Regular Users cannot see other teacher's info pages
Given I am logged in as "<user>" with password "secret"
When I go to the info page of teacher "<teacher>"
Then I should be redirected to the <default> page of <status> "<user>"
	And I should see 'people.error.unauthorized_access'
Examples:
|	user						|	teacher				|	default	|	status	|
|	chris_the_man		|	prince_philip	|	info		|	teacher	|
|	prince_philip		|	chris_the_man	|	info		|	teacher	|
| kurosawa_akira	|	prince_philip	|	reserve	|	student	|
| kurosawa_akira	|	chris_the_man	|	reserve	|	student	|