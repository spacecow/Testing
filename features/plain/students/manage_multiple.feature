@multiple_students
Background:
Given the following teacher records
|	user_name			|	password	| family_name	| first_name	|
|	johan_sveholm	|	secret		|	Sveholm			|	Johan				|
|	komatsu_aya		|	secret		|	Komatsu			|	Aya					|
|	thomas_osburg	|	secret		|	Osburg			|	Thomas			|
|	prince_philip	|	secret		|	Prince			|	Philip			|
Given the following student records
|	user_name					|	password	| family_name	| first_name	|
|	kurosawa_akira		|	secret		|	Kurosawa		|	Akira				|
|	sakurai_kazutoshi	|	secret		|	Sakurai			|	Kazutoshi		|
|	asada_mao					|	secret		|	Asada				|	Mao					|
Given I go to the list of teachers

Scenario Outline: No selected teachers should generate an error message
Given I am logged in as "<user>" with password "secret"
When I multiselect no students
Then I should be redirected to the list of people
	And I should see 'students.error.select'
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|

Scenario Outline: Observers cannot multiselect
Given I am logged in as "<user>" with password "secret"
When I go to the multi course page of student "asada_mao"
Then I should be redirected to the <default>
Examples:
|	user						|	default																		|
|	thomas_osburg		|	list of classes														|
|	prince_philip		|	info page of teacher "prince_philip"			|
|	kurosawa_akira	|	reserve page of student "kurosawa_akira"	|

Scenario Outline: List selected students
Given I am logged in as "<user>" with password "secret"
	And I multiselect students "kurosawa_akira, sakurai_kazutoshi"
	And I should see "Kurosawa Akira" within "students"
	And I should see "Sakurai Kazutoshi" within "students"
	And I should not see "Asada Mao" within "students"
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|

Scenario Outline: Update multiple students with blank courses should generate no change
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And student "kurosawa_akira" has courses "Java, Prolog"
	And student "asada_mao" has course "Cpp"
	And I am logged in as "<user>" with password "secret"
When I multiselect students "kurosawa_akira, sakurai_kazutoshi, asada_mao"
	And I press 'update'
Then student "kurosawa_akira" should have courses "Java, Prolog"
	And student "asada_mao" should have courses "Cpp"
	And student "sakurai_kazutoshi" should have 0 courses
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|

Scenario Outline: Update courses for multiple students
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And I am logged in as "<user>" with password "secret"
	And I multiselect students "kurosawa_akira, sakurai_kazutoshi"
	And I check "Java"
	And I check "Prolog"
	And I press 'update'
Then students "kurosawa_akira, sakurai_kazutoshi" should have courses "Java, Prolog"
	And student "asada_mao" should have 0 courses
	And I should see 'students.updated'
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|

Scenario Outline: Cancel courses for multiple students
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And I am logged in as "<user>" with password "secret"
	And students "kurosawa_akira, sakurai_kazutoshi" has courses "Fortran, Cpp"
When I multiselect students "kurosawa_akira, asada_mao"
	And I check 'courses.none'
	And I press 'update'
Then students "kurosawa_akira, asada_mao" should have 0 courses
	And student "sakurai_kazutoshi" should have courses "Fortran, Cpp"
	And I should see 'students.updated'
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|
	
Scenario Outline: Cancel courses for multiple students but keep one course
Given I have courses titled "Java, Prolog, Fortran, Cpp"
	And I am logged in as "<user>" with password "secret"
	And students "kurosawa_akira, sakurai_kazutoshi" have courses "Fortran, Cpp"
When I multiselect students "kurosawa_akira, asada_mao"
	And I check "Fortran"
	And I check 'courses.none'
	And I press 'update'
Then students "kurosawa_akira, asada_mao" should have course "Fortran"
	And student "sakurai_kazutoshi" should have courses "Fortran, Cpp"
	And I should see 'students.updated'
Examples:
	|	user					|
	|	johan_sveholm	|
	|	komatsu_aya		|	