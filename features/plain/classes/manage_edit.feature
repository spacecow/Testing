@class_edit
Background:
Given I have courses "Java I, Ruby I"
	And the following class record
	| id	|	course	|
	|	1		|	Java I	|
	|	2		|	Ruby I	|
	|	3		|	Ruby I	|
	And I have teachers "prince_philip, johan_sveholm, komatsu_aya, thomas_osburg"
	And the following student record
	| user_name 			|	family_name	|	first_name	|
	|	kurosawa_akira	|	Kurosawa		|	Akira				|
	|	asada_mao				|	Asada				|	Mao					|

Scenario: Login is required to see the class's edit page
When I go to the edit page of class "1"
Then I should be redirected to the login page

Scenario Outline: Admin can see edit page
Given I am logged in as "<user>"
When I go to the edit page of class "1"
Then I should be redirected to the the edit page of class "1"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|

Scenario Outline: Observer&regular users cannot see edit page
Given I am logged in as "<user>"
When I go to the edit page of class "1"
Then I should be redirected to the the <default> page of <status> "<user>"
|	user						|	default	|	status 	|
|	thomas_osburg		|	info		|	teacher	|
|	kurosawa_akira	|	info		|	teacher	|
|	prince_philip		|	reserve	|	student	|

Scenario Outline: If there are no students, student title should not be visible
Given I am logged in as "<user>"
When I go to the edit page of class "1"
Then I should not see 'students.title' within "students"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|

Scenario Outline: Non-chosen students should be (visible) for admin
Given class "2" has student "kurosawa_akira"
	And I am logged in as "<user>"
When I go to the edit page of class "2"
Then I should see 'students.title' within "students"
	And I should see "(Kurosawa Akira)" within "students"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|

Scenario Outline: Chosen students should be visible for admin
Given class "1" has chosen students "kurosawa_akira, asada_mao"
	And I am logged in as "<user>"
When I go to the edit page of class "1"
Then I should see 'students.title' within "students"
	And I should see "Kurosawa Akira "'show' within "students"
	And I should not see "(Kurosawa" within "students"
	And I should see "Asada Mao "'show' within "students"
	And I should see 'cancel' within "students"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|

Scenario Outline: Canceled students should be (visible) for admin&observer
Given class "2" has canceled students "kurosawa_akira, asada_mao"
	And I am logged in as "<user>"
When I go to the edit page of class "2"
Then I should see 'students.title' within "students"
	And I should see "(Kurosawa Akira "'info' within "students"
	And I should see "(Asada Mao "'info' within "students"
	And I should see 'uncancel' within "students"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|