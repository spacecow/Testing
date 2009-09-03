@class_show
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

Scenario: Login is required to see the class's show page
When I go to the info page of class "1"
Then I should be redirected to the login page

Scenario Outline: Admin&observer should see all fields
Given I am logged in as "<user>"
When I go to the info page of class "1"
Then I should see 'teacher' within "form"
	And I should see 'classroom' within "form"
	And I should see 'capacity' within "form"
	And I should see 'mail_sending' within "form"
	And I should see 'cancel' within "form"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|
|	thomas_osburg		|

Scenario Outline: Regular users do not see all class's fields on its show page
Given teacher "prince_philip" has course "Java I"
	And teacher "prince_philip" has class "1"
	And student "kurosawa_akira" has course "Ruby I"
	And I am logged in as "<user>"
	And I should be redirected to the <default> page of <status> "<user>"
When I follow "<course>: 12:00~15:00" within "classes"
Then I should be redirected to the info page of class "<no>"
	And I should not see 'teacher' within "form"
	And I should not see 'classroom' within "form"
	And I should not see 'capacity' within "form"
	And I should not see 'mail_sending' within "form"
	And I should not see 'cancel' within "form"
Examples:
|	user						|	default	|	status	|	course	|	no	|
|	prince_philip		|	info		|	teacher	|	Java I	|	1		|
|	kurosawa_akira	|	reserve	|	student	|	Ruby I	|	2		|

@access_denied
Scenario: Regular users should not be able to see the show page of classes they cannot choose
Given student "kurosawa_akira" has course "Ruby I"
	And student "kurosawa_akira" has class "3"
	And I am logged in as "kurosawa_akira"
When I go to the info page of class "3"
Then I should be redirected to the info page of class "3"
When I go to the info page of class "2"
Then I should be redirected to the info page of class "2"
When I go to the info page of class "1"
Then I should be redirected to the reserve page of student "kurosawa_akira"
	And I should see 'people.error.unauthorized_access'
	
Scenario Outline: If there are no students, student title should not be visible		
Given I am logged in as "<user>"
When I go to the info page of class "1"
Then I should not see 'students.title' within "students"
Examples:
|	user						|
|	johan_sveholm		|
|	komatsu_aya			|
|	thomas_osburg		|
|	kurosawa_akira	|
|	prince_philip		|
	
Scenario Outline: Non-chosen students should be (visible) for admin&observer
Given class "2" has student "kurosawa_akira"
	And I am logged in as "<user>"
When I go to the info page of class "2"
Then I should <view> 'students.title' within "students"
	And I should <view> "(Kurosawa Akira)"
Examples:
|	user						|	view		|
|	johan_sveholm		|	see			|
|	komatsu_aya			|	see			|
|	thomas_osburg		|	see			|
|	kurosawa_akira	|	not see	|
|	prince_philip		|	not see	|
	
Scenario Outline: Chosen students should be visible for admin&observer
Given class "1" has chosen students "kurosawa_akira, asada_mao"
	And I am logged in as "<user>"
When I go to the info page of class "1"
Then I should <view> 'students.title' within "students"
	And I should <view> "Kurosawa Akira"
	And I should <view> "Asada Mao"
Examples:
|	user						|	view		|
|	johan_sveholm		|	see			|
|	komatsu_aya			|	see			|
|	thomas_osburg		|	see			|
|	kurosawa_akira	|	not see	|
|	prince_philip		|	not see	|

Scenario Outline: Canceled students should be (visible) for admin&observer
Given class "2" has canceled students "kurosawa_akira, asada_mao"
	And I am logged in as "<user>"
When I go to the info page of class "2"
Then I should <view> 'students.title' within "students"
	And I should <view> "(Kurosawa Akira "'canceled'
	And I should <view> "(Asada Mao "'canceled'
Examples:
|	user						|	view		|
|	johan_sveholm		|	see			|
|	komatsu_aya			|	see			|
|	thomas_osburg		|	see			|
|	kurosawa_akira	|	not see	|
|	prince_philip		|	not see	|