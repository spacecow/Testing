@teachings

Background:
Given the following teacher records
|	user_name 		|	password	|
|	prince_philip	|	secret		|
|	chris_the_man	|	secret		|
|	johan_sveholm	|	secret		|
|	komatsu_aya		|	secret		|
|	thomas_osburg	|	secret		|

Scenario Outline: Regular teacher has no courses and no classes
Given I have no courses
When I am logged in as "<user>" with password "secret"
	And I go to the course page of teacher "chris_the_man"
Then I should not see 'courses.title' within "courses"
Examples:
|	user					|	name					|
| johan_sveholm	|	chris_the_man	|
| komatsu_aya		|	prince_philip	|

Scenario Outline: Chosing Courses on the Teacher Course Page
Given I have courses titled "Java I, Java VI, Fortran, Cpp"
	And I am logged in as "<user>" with password "secret"
	And I go to the course page of teacher "prince_philip"
	And I should see 'courses.title' within "courses"
	And the "Java I" checkbox should not be checked
	And the "Java VI" checkbox should not be checked
	And the "Fortran" checkbox should not be checked
	And the "Cpp" checkbox should not be checked	
When I check "Java I"
	And I check "Fortran"
	And I press 'update'
Then the "Java I" checkbox should be checked
	And the "Fortran" checkbox should be checked
	And I should not see "Java VI"
	And I should not see "Cpp"
When I follow 'courses.title' within "links"
Then the "Java I" checkbox should be checked
	And the "Java VI" checkbox should not be checked
	And the "Fortran" checkbox should be checked
	And the "Cpp" checkbox should not be checked	
Examples:
|	user					|
|	johan_sveholm	|
| komatsu_aya		|

Scenario Outline: Deleting Courses on the Teacher Course Page
Given I have courses titled "Java I, Java VI, Fortran, Cpp"
	And teacher "prince_philip" has courses "Java I, Fortran"
	And I am logged in as "<user>" with password "secret"
	And I go to the course page of teacher "prince_philip"
	And the "Java I" checkbox should be checked
	And the "Java VI" checkbox should not be checked
	And the "Fortran" checkbox should be checked
	And the "Cpp" checkbox should not be checked
When I uncheck "Java I"
	And I uncheck "Fortran"
	And I press 'update'
Then I should not see 'courses.title' within "courses"
	And I should not see "Java I" within "courses"
	And I should not see "Java VI" within "courses"
	And I should not see "Fortran" within "courses"
	And I should not see "Cpp" within "courses"
When I follow 'courses.title' within "links"
Then the "Java I" checkbox should not be checked
	And the "Java VI" checkbox should not be checked
	And the "Fortran" checkbox should not be checked
	And the "Cpp" checkbox should not be checked
Examples:
|	user					|
|	johan_sveholm	|
| komatsu_aya		|

Scenario Outline: Edit Teachings on the Teacher Course Page
Given I have courses titled "Ruby, Pascal"
	And teacher "johan_sveholm" has courses "Ruby, Pascal"
	And I am logged in as "<user>" with password "secret"
	And I go to the course page of teacher "johan_sveholm"
	And I should see "1500" within "Ruby"
	And I follow 'edit' within "Ruby"
When I fill in 'cost' with "1600"
	And I press 'update'
Then I should see "1600" within "Ruby"
Examples:
| user 					|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Links on the Teacher Course Page
Given I am logged in as "<user>" with password "secret"
	And I go to the course page of teacher "prince_philip"
When I follow 'info' within "links"
Then I should be on the info page of teacher "prince_philip"
Examples:
|	user					|
|	johan_sveholm	|
| komatsu_aya		|

Scenario Outline: Regular Teachers cannot see their own course page
Given I am logged in as "<user>" with password "secret"
When I go to the course page of teacher "<user>"
Then I should be redirected to the info page of teacher "<user>"
	And I should see 'people.error.unauthorized_access'
Examples:
|	user						|
|	prince_philip		|
|	chris_the_man		|

Scenario Outline: Regular Users cannot see other teacher's course pages
Given the following student records
|	user_name 			|	password	|
|	kurosawa_akira	|	secret		|
|	koda_kumiko			|	secret		|
Given I am logged in as "<user>" with password "secret"
When I go to the course page of teacher "<teacher>"
Then I should be redirected to the <default> page of <status> "<user>"
	And I should see 'people.error.unauthorized_access'
Examples:
|	user						|	teacher 			|	default	|	status	|
|	chris_the_man		|	prince_philip	|	info		|	teacher	|
|	prince_philip		|	chris_the_man	|	info		|	teacher	|
| kurosawa_akira	|	prince_philip	|	reserve	|	student	|
| kurosawa_akira	|	chris_the_man	|	reserve	|	student	|
| koda_kumiko			|	prince_philip	|	reserve	|	student	|
| koda_kumiko			|	chris_the_man	|	reserve	|	student	|

Scenario Outline: Staff Viewer cannot see other teacher's course pages
Given I am logged in as "thomas_osburg" with password "secret"
When I go to the course page of teacher "<user>"
Then I should be redirected to the info page of teacher "<user>"
Examples:
|	user						|
|	chris_the_man		|
|	prince_philip		|