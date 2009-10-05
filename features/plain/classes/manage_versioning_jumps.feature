@versioning_jump
Background:
Given I have course "Ruby I"
	And the following class record
	|	id	|	course	|	start_time	|	end_time	|
	|	1		|	Ruby I	|	11:00				|	12:00			|
	And I have teachers "prince_philip, johan_sveholm, komatsu_aya, thomas_osburg"
	And I have student "kurosawa_akira"
	And teacher "prince_philip" has course "Ruby I"
	And teacher "prince_philip" has class "1"
	And I am logged in as "prince_philip"
	And I follow "Ruby I: 11:00~12:00" within "classes"
	And I fill in 'note' with "It works!"
	And I press 'update'
	And I fill in 'note' with "Awesome!"
	And I press 'update'

Scenario: Regular teachers can jump between versions
Then I should see 'version'" 3" within "links"
	And the 'note' field should contain "Awesome!"
When I follow 'previous_version' within "links"
Then I should see 'version'" 2" within "links"
	And I should see 'latest_version' within "links"
	And the 'note' field should contain "It works!"	
When I follow 'previous_version' within "links"
Then I should see 'version'" 1" within "links"
When I follow 'latest_version' within "links"
Then I should see 'version'" 3" within "links"

Scenario: Regular users can jump between versions
Given I go to the logout page
Given student "kurosawa_akira" has course "Ruby I"
	And student "kurosawa_akira" has class "1"	
	And I log in as "kurosawa_akira"
When I follow "Ruby I: 11:00~12:00" within "classes"
Then I should see 'version'" 3" within "links"
	And I should see "Awesome!"
When I follow 'previous_version' within "links"
Then I should see 'version'" 2" within "links"
	And I should see 'latest_version' within "links"
	And I should see "It works!"
When I follow 'previous_version' within "links"
Then I should see 'version'" 1" within "links"
When I follow 'latest_version' within "links"
Then I should see 'version'" 3" within "links"

Scenario Outline: Admin&observes can jump between versions
Given I go to the logout page
	And I log in as "<user>"
When I follow 'info' within "klass_1"
Then I should see 'version'" 3" within "links"
	And I should see "Awesome!"
When I follow 'previous_version' within "links"
Then I should see 'version'" 2" within "links"
	And I should see 'latest_version' within "links"
	And I should see "It works!"
When I follow 'previous_version' within "links"
Then I should see 'version'" 1" within "links"
When I follow 'latest_version' within "links"
Then I should see 'version'" 3" within "links"
Examples:
| user |
| johan_sveholm	|
|	komatsu_aya		|
|	thomas_osburg	|