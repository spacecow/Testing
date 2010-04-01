Background:
Given a setting exists with name: "main"
	And a course: "1" exists with name: "初級 I"
	And a course: "2" exists with name: "初級 II"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm", email: "johan@space.com"

@check
Scenario: I&II should be replaced with　文法&会話　in the mails
	And a klass: "6" exists with date: "2010-04-06", course: course "2", start_time: "12:00", end_time: "12:50"
	And a klass: "7" exists with date: "2010-04-07", course: course "1", start_time: "12:00", end_time: "12:50"
	And a teaching exists with klass: klass "6", teacher: user "johan"
	And a teaching exists with klass: klass "7", teacher: user "johan"
When the system sends out the weekly schedule to concerned teachers from "2010-04-05"
	And "johan@space.com" opens the email with subject "来週のシフトについて"
Then I should see "4/6(火) 12:00~12:50(初級会話)" in the email body
	And I should see "4/7(水) 12:00~12:50(初級文法)" in the email body

#4/6(火曜日) - 初級 II - 12:00~12:50
#4/6(火曜日) - 初級 I - 13:00~15:00
#4/7(水曜日) - 初級 II - 18:50~19:40
#4/7(水曜日) - 初級 II - 19:50~20:40
#4/9(金曜日) - 初級 I - 18:50~20:50
#4/10(土曜日) - 初級 II - 15:00~15:50
#4/10(土曜日) - 初級 I - 16:00~18:00
#4/10(土曜日) - 初級 I - 18:30~20:30

#4/6 (火) 12:00～15:00(初級)
#4/7 (水) 12:00～15:00、18:50～20:40(初級・会話)
#4/9 (金) 18:50～20:50(初級・文法)
#4/10(土） 15:00～18:00、18:30～20:30(初級・文法)


#4/10() 15:00~15:50(初級会話), 1600~18:00(初級文法),　18:30~20:30(初級文法)