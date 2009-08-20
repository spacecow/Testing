@multiple_teachers
Background:
Given the following teacher records
|	user_name			|	password	| family_name	| first_name	|
|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
|	thomas_osburg	|	secret		|	Osburg			|	Thomas			|
|	prince_philip	|	secret		|	Prince			|	Philip			|
Given the following student record
|	user_name				|	password	|
|	kurosawa_akira	|	secret		|
Given I go to the list of teachers

Scenario Outline: No selected teachers should generate an error message
Given I am logged in as "<user>" with password "secret"
When I multiselect teachers ""
Then I should be redirected to the list of people
	And I should see 'teachers.error.select'
Examples:
|	user					|
|	johan_sveholm	|
|	komatsu_aya		|
	
Scenario Outline: Observers cannot multiselect
Given I am logged in as "<user>" with password "secret"
When I go to the multi course page of teacher "komatsu_aya"
Then I should be redirected to the <default>
Examples:
|	user						|	default																		|
|	thomas_osburg		|	list of classes														|
|	prince_philip		|	info page of teacher "prince_philip"			|
|	kurosawa_akira	|	reserve page of student "kurosawa_akira"	|

Scenario Outline: List selected teachers
Given I am logged in as "<user>" with password "secret"
When I multiselect teachers "johan_sveholm, thomas_osburg"
Then I should see "Sveholm Johan" within "teachers"
	And I should not see "Komatsu Aya" within "teachers"
	And I should see "Osburg Thomas" within "teachers"
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|
	
Scenario Outline: Update multiple teachers with blank courses should generate no change
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And that teacher "johan_sveholm" has courses "Java, Prolog"
	And that teacher "prince_philip" has course "Cpp"
	And I am logged in as "<user>" with password "secret"
When I multiselect teachers "johan_sveholm, thomas_osburg, prince_philip"
	And I press 'update'
Then teacher "johan_sveholm" should have courses "Java, Prolog"
	And teacher "prince_philip" should have courses "Cpp"
	And teacher "thomas_osburg" should have 0 courses
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|

Scenario Outline: Update courses for multiple teachers
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And I am logged in as "<user>" with password "secret"
When I multiselect teachers "johan_sveholm, thomas_osburg"
	And I check "Java"
	And I check "Prolog"
	And I press 'update'
Then teachers "johan_sveholm, thomas_osburg" should have courses "Java, Prolog"
	And teacher "komatsu_aya" should have 0 courses
	And I should see 'teachers.updated'
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|

Scenario Outline: Cancel courses for multiple teachers
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And I am logged in as "<user>" with password "secret"
	And that teachers "johan_sveholm, thomas_osburg" has courses "Fortran, Cpp"
When I multiselect teachers "johan_sveholm, komatsu_aya"
	And I check 'courses.none'
	And I press 'update'
Then teachers "johan_sveholm, komatsu_aya" should have 0 courses
	And teacher "thomas_osburg" should have courses "Fortran, Cpp"
	And I should see 'teachers.updated'
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|
