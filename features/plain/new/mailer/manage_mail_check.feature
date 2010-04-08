Background:
Given a setting exists with name: "main"
	And a course: "1" exists with name: "初級 I"
	And a course: "2" exists with name: "初級 II"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"
	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "ja", name: "Aya Komatsu", email: "aya@space.com"

@check
Scenario Outline: I&II should be replaced with　文法&会話　in the mails
Given a klass: "6" exists with date: "2010-04-06", course: course "2", start_time: "12:00", end_time: "12:50"
	And a klass: "7" exists with date: "2010-04-07", course: course "1", start_time: "12:00", end_time: "12:50"
	And a teaching exists with klass: klass "6", teacher: user "<user>"
	And a teaching exists with klass: klass "7", teacher: user "<user>"
When the system sends out the weekly schedule to concerned teachers from "2010-04-05"
	And "<user>@space.com" opens the email with subject "<subject>"
Then I should see "<tuesday>" in the email body
	And I should see "<wednesday>" in the email body
Examples:
|	user	|	subject									|	tuesday											| wednesday										|
|	johan	| Schedule for next week	|	4/6(tue) 12:00～12:50(conv.)	|	4/7(wed) 12:00～12:50(gram.)	|
|	aya		| 来週のシフトについて							|	4/6(火) 12:00～12:50(会話)			|	4/7(水) 12:00～12:50(文法)			|

Scenario: If there are two classes on the same they, they should be listed on the same line
Given a klass: "6-1" exists with date: "2010-04-06", course: course "2", start_time: "12:00", end_time: "12:50"
	And a klass: "6-2" exists with date: "2010-04-06", course: course "1", start_time: "13:00", end_time: "15:00"
	And a teaching exists with klass: klass "6-1", teacher: user "aya"
	And a teaching exists with klass: klass "6-2", teacher: user "aya"
When the system sends out the weekly schedule to concerned teachers from "2010-04-05"
	And "aya@space.com" opens the email with subject "来週のシフトについて"
Then I should see "4/6(火) 12:00～12:50(会話), 13:00～15:00(文法)" in the email body

@mark
Scenario Outline: If a teacher is assigned a class for another level, that should be marked
Given a course: "nyuumon" exists with name: "入門 I"
	And a klass: "5" exists with date: "2010-04-05", course: course "2", start_time: "12:00", end_time: "12:50"
	And a klass: "7" exists with date: "2010-04-07", course: course "1", start_time: "12:00", end_time: "12:50"
	And a klass: "8" exists with date: "2010-04-08", course: course "nyuumon", start_time: "12:00", end_time: "12:50"
	And a teaching exists with klass: klass "5", teacher: user "<user>"
	And a teaching exists with klass: klass "7", teacher: user "<user>"
	And a teaching exists with klass: klass "8", teacher: user "<user>"
When the system sends out the weekly schedule to concerned teachers from "2010-04-05"
	And "<user>@space.com" opens the email with subject "<subject>"
Then I should see "<monday>" in the email body
	And I should see "<wednesday>" in the email body
	And I should see "<thursday>" in the email body
Examples:
|	user	|	subject									|	monday											| wednesday										|	thursday													|
|	johan	| Schedule for next week	|	4/5(mon) 12:00～12:50(conv.)	|	4/7(wed) 12:00～12:50(gram.)	| 4/8(thu) 12:00～12:50(入門 gram.)		|
|	aya		| 来週のシフトについて							|	4/5(月) 12:00～12:50(会話)			|	4/7(水) 12:00～12:50(文法)			| 4/8(木) 12:00～12:50(入門文法)					|