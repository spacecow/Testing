Scenario: Display Courses
  Given the following teacher record
  | user_name     | password |
  | johan_sveholm | secret   |
	Given I have courses titled "入門 I, 初級 II"
  When I go to the list of courses
	And I am logged in as "johan_sveholm" with password "secret"
  Then I should see "入門 I"
  And I should see "初級 I"
  
Scenario Outline: Trying to Delete Courses
	Given I have courses titled "入門 I, 入門 II, 初級 II, 中級 I, 個別 英語"
  Given the following teacher record
  | user_name     | password |
  | johan_sveholm | secret   |
  Given the following template klass record
	|	course	|
	|	入門 I		|
	|	個別 英語	|
  Given the following klass records
	|	course	|
	|	入門 I		|
	|	初級 II	|
  And I go to the list of courses
	And I am logged in as "johan_sveholm" with password "secret"
	When I follow 'delete' in the row containing "<delete>"
	Then I should <error_1> 'courses.flash.try_to_delete_course_with_template_classes'
	And I should <error_2> 'courses.flash.try_to_delete_course_with_klasses'	
	And I should <item_1> "入門 I"
	And I should <item_2> "入門 II"	
	And I should <item_3> "初級 II"
	And I should <item_4> "中級 I"
	And I should <item_5> "個別 英語"	
	And I should have <courses> courses

  Examples:
  |	delete	|	error_1	|	error_2	|	item_1	|	item_2	|	item_3	|	item_4	|	item_5	| courses	|
  |	入門 I		|	see			|	see			|	see			|	see			|	see			|	see			|	see			|	5				|
  |	入門 II	|	not see	|	not see	|	see			|	not see	|	see			|	see			|	see			|	4				|
  |	初級 II	|	not see	|	see			|	see			|	see			|	see			|	see			|	see			|	5				|
  |	中級 I		|	not see	|	not see	|	see			|	see			|	see			|	not see |	see			|	4				|
  |	個別 英語	|	see			|	not see	|	see			|	see			|	see			|	see			|	see			|	5				|
  
Scenario Outline: Display Associations
	Given I have courses titled "入門 I, 入門 II, 初級 II, 中級 I, 個別 英語"
  Given the following teacher record
  | user_name     | password |	language	|
  | johan_sveholm | secret   |	en				|
  Given the following template klass record
	|	course	|	day				| start_time	|	end_time	|
	|	入門 I		|	Friday		| 11:00				| 12:00			|
	|	個別 英語	|	Saturday	|	13:00				|	13:50			|
  Given the following klass records
	|	course	|	date			| start_time	|	end_time	|
	|	入門 I		|	06/30/09	| 11:00				| 11:50			|
	|	初級 II	|	07/01/09	|	12:00				|	14:00			|
	And I go to the list of courses
	And I am logged in as "johan_sveholm" with password "secret"
	When I follow 'show' in the row containing "<show>"
	Then I should <day_1> "Friday"
	And I should <time_1> "11:00~12:00"
	And I should <day_2> "Saturday"
	And I should <time_2> "13:00~13:50"	
	And I should <day_3> "Tuesday"
	And I should <time_3> "11:00~11:50"
	And I should <day_4> "Wednesday"
	And I should <time_4> "12:00~14:00"	
	
	Examples:
	|	show		|	day_1		| time_1	|	day_2		| time_2	| day_3		|	time_3	| day_4		|	time_4	|
	|	入門 I		|	see			| see			| not see	|	not see	|	see			|	see			|	not see |	not see	|
	|	入門 II	|	not see	| not see	| not see	| not see	|	not see	|	not see	|	not see	|	not see	|
	|	初級 II	|	not see	| not see	| not see	| not see	|	not see	| not see	|	see			|	see			|
	|	中級 I		|	not see	| not see	| not see	| not see	|	not see	| not see	|	not see	|	not see	|
	|	個別 英語	|	not see	| not see	| see			| see			|	not see	| not see	|	not see	|	not see	|
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	