@cjax
Background:
Given I have courses titled "Java I, Java II, Java III, Ruby I"
	And the following teacher records
	| user_name 		|	password	|	first_name	|	family_name	|
	|	johan_sveholm	|	secret		|	Johan				|	Sveholm			|
	|	komatsu_aya		|	secret		|	Aya					|	Komatsu			|
	|	thomas_osburg	|	secret		|	Thomas			|	Osburg			|
  And that teacher "johan_sveholm" has course "Java I"
  And that teacher "komatsu_aya" has courses "Java I, Java II, Java III"
  And that teacher "thomas_osburg" has course "Java I, Ruby I"
  And the following template class records
  |	id	|	course		|
  |	1		|	Java I		|
  |	2		|	Java I		|
  |	3		|	Java I		|
  |	4		|	Java II		|
  |	5		|	Java III	|
  |	6		|	Ruby I		|
	And I am logged in as "johan_sveholm" AJAX
	And I browse to "template_classes"
  
Scenario: Change course and the available teachers should change
When I click link 'template_klasses.new'
Then I should see options "Java I, Java II, Java III, Ruby I" for "template_class_course_id"
When I click button "template_class_submit"
Then I should see options "Java I, Java II, Java III, Ruby I" for "template_class_course_id"
When I select option "Java I" from "template_class_course_id"
Then I should see options "Sveholm Johan, Komatsu Aya, Osburg Thomas" for "template_class_teacher_id"
When I select option "Java II" from "template_class_course_id"
Then I should see options "Komatsu Aya" for "template_class_teacher_id"
When I select option "Java III" from "template_class_course_id"
Then I should see options "Komatsu Aya" for "template_class_teacher_id"
When I select option "Ruby I" from "template_class_course_id"
Then I should see options "Osburg Thomas" for "template_class_teacher_id"