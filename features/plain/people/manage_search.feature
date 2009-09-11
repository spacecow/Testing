@searching
Scenario: Searching
Given the following teacher records
| user_name 		|	password	|	first_name	|	family_name	|
|	johan_sveholm	|	secret		|	Johan				|	Sveholm		|
	And I am logged in as "johan_sveholm"
	And I go to the list of people