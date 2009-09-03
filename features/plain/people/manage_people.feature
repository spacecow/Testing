@people
Scenario: Observer's index page
Given I have teacher "thomas_osburg"
	And I am logged in as "thomas_osburg"
When I go to the list of people
Then I should not see 'students.new' within "links"
	And I should not see 'teachers.new' within "links"
	
Scenario Outline: Admin's index page
Given I have teachers "johan_sveholm, komatsu_aya"
	And I am logged in as "<user>"
When I go to the list of people
Then I should see 'students.new' within "links"
	And I should see 'teachers.new' within "links"
Examples:
|	user					|
|	johan_sveholm	|
|	komatsu_aya		|

Scenario Outline: Regular users should not be able to see index page
Given I have teacher "prince_philip"
	And I have student "kurosawa_akira"
	And I am logged in as "<user>"
When I go to the list of people
Then I should be redirected to the <default> page of <status> "<user>"
Examples:
|	user						|	default	|	status	|
|	prince_philip		|	info		|	teacher	|
|	kurosawa_akira	|	reserve	|	student	|