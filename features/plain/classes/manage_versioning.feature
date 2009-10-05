@versioning
Background:
Given I have course "Ruby I"
	And the following class record
	|	id	|	course	|	start_time	|	end_time	|
	|	1		|	Ruby I	|	11:00				|	12:00			|
	And I have teachers "prince_philip, johan_sveholm, komatsu_aya, thomas_osburg"
	And I have student "kurosawa_akira"

Scenario Outline: Admin&observer should see Version info
Given I am logged in as "<user>"
	#And I should be redirected to the list of classes
	When I follow 'show' within "klass_1"
	Then I should see "Version 1" within "links"
Examples:
| user		 			|
|	johan_sveholm	|
|	komatsu_aya		|
|	thomas_osburg	|

Scenario Outline: Regular users should see Version info
Given <status> "<user>" has course "Ruby I"
	And <status> "<user>" has class "1"
	And I am logged in as "<user>"
When I follow "Ruby I: 11:00~12:00" within "classes"
Then I should see "Version 1"
	And I should <view> a tag "form"
Examples:
| user						|	status	| view 			|
| prince_philip		|	teacher |	have			|
|	kurosawa_akira	|	student	|	not have	|

Scenario: Regular teacher can upate note
Given teacher "prince_philip" has course "Ruby I"
	And teacher "prince_philip" has class "1"
	And I am logged in as "prince_philip"
When I follow "Ruby I: 11:00~12:00" within "classes"
	And I fill in 'note' with "It works!"
	And I press 'update'
Then I should be redirected to the info page of class "1"
	And I should see "Version 2"
	And the 'note' field should contain "It works!"
	
Scenario: Classes with updated note-fields should be highlighted for regular users (NOT IMPLEMENTED)
	Given not implemented