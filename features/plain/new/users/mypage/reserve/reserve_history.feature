# Background:
# Given a setting exist with name: "main"
# 	And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
# 	And a user: "junko" exist with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
# 	And a course: "ruby" exists with name: "Ruby I", level_en: "beg.", level_ja: "初級"
# 	And a courses_student join model exists with course: "Ruby I", student: "junko"
# 	And a klass: "19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
# 	And a klass: "18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"

	
# @reserved_history_reserve
# Scenario: Classes in Reserved and History should not cease to exist if another reservation is made
# Given a klass: "15" exists with date: "2010-02-15", course: course "ruby", start_time: "12:00", end_time: "13:00"
# 	And an attendance exists with student: user "junko", klass: klass "18"
# 	And an attendance exists with student: user "junko", klass: klass "15"
# 	And a user is logged in as "aya"
# When I go to the reserve page for user: "junko" on "2010-03-06"
# 	And I check "3/19(Friday) - Ruby I - 12:00~13:00"
# 	And I press "Reserve"
# Then 1 attendances should exist with student: user "junko", klass: klass "18"
# 	And 1 attendances should exist with student: user "junko", klass: klass "19"
# 	And 1 attendances should exist with student: user "junko", klass: klass "15"
# 	And 3 attendances should exist

# @hidden_history_reserve
# Scenario: Reserve a class with already reserved classes not showing up in the history
# Given an attendance exists with student: user "junko", klass: klass "18"
# 	And a klass: "25" exists with date: "2010-03-25", course: course "ruby", start_time: "12:00", end_time: "13:00"
# 	And a user is logged in as "aya"
# When I go to the reserve page for user: "junko" on "2010-3-13"
# 	And I check "3/25(Thursday) - Ruby I - 12:00~13:00"
# 	And I press "Reserve"
# Then 1 attendances should exist with student: user "junko", klass: klass "25"
# 	And 1 attendances should exist with student: user "junko", klass: klass "18"
# 	And 2 attendances should exist

# @history @cancel @absent
# Scenario Outline: Canceled&absent classes should not show up in history unless admin
# Given a user: "junko" exists with username: "junko", role: "registrant, student"
# And a klass: "15" exists with date: "2010-03-15", course: course "ruby"
# And a klass: "19" exists with date: "2010-03-19", course: course "ruby"
# And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
# And a klass: "22" exists with date: "2010-03-29", course: course "ruby"
# And an attendance exist with student: user "junko", klass: klass "15", absent: true
# And an attendance exist with student: user "junko", klass: klass "18", cancel: true
# And an attendance exist with student: user "junko", klass: klass "19"
# And a user is logged in as "<user>"
# When I browse to the reserve history page for user: "junko" for "03/29～04/03"
# Then I should <away> "3/15(Monday) - Ruby I - 12:00~15:00"
# And I should <away> "3/18(Thursday) - Ruby I - 12:00~15:00"
# And I should see "3/19(Friday) - Ruby I - 12:00~15:00"
# Examples:
# | user  | away    |
# | johan | see     |

# # junko not see

