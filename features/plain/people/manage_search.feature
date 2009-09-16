@searching
Background:
Given the following teacher records
| user_name 		|	password	|	first_name	|	family_name	| tostring			|
|	johan_sveholm	|	secret		|	Johan				|	Sveholm			|	Sveholm Johan	|
|	komatsu_aya		|	secret		|	Aya					|	Komatsu			| Komatsu Aya		|
|	thomas_osburg	|	secret		|	Thomas			|	Osburg			| Osburg Thomas	|
|	prince_philip	|	secret		|	Philip			|	Prince			| Prince Philip	|
	And I am logged in as "johan_sveholm"
	And I go to the list of people

Scenario: Nothing should be listed when you first reach there
Then I should not see "Sveholm Johan"
	And I should not see "Osburg Thomas"
	And I should not see "Komatsu Aya"
	And I should not see "Prince Philip"
	
Scenario: Everyone should be listed when nothing is filled in
When I press 'search'
Then I should see "Sveholm Johan"
	And I should see "Osburg Thomas"
	And I should see "Komatsu Aya"
	And I should see "Prince Philip"

Scenario: Search for a string
When I fill in 'name' with "o"
	And I press 'search'
Then I should see "Sveholm Johan"
	And I should see "Osburg Thomas"
	And I should see "Komatsu Aya"
	And I should not see "Prince Philip"	
	
Scenario: Search for a name and a phone number
Given teacher "johan_sveholm" has mobile phone "08052206600"
When I fill in 'name' with "o"
	And I fill in 'mobile_phone' with "0"
	And I press 'search'
Then I should see "Sveholm Johan"
	And I should not see "Osburg Thomas"
	And I should not see "Komatsu Aya"
	And I should not see "Prince Philip"