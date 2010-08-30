Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a user: "prince" exists with role: "teacher"

@confirm
Scenario: Confirm a class
Given a user is logged in as "johan"
And a klass exists with date: "2010-08-20"
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-18"
And I confirmed the klass
And I press "Confirm"
Then I should see "Successfully confirmed class(es)." as notice flash message
And I should be redirected to the already confirmed page for user: "prince"
And a teaching should exist with klass: that klass, teacher: user "prince", status_mask: 33
And 1 teachings should exist

@over_write
Scenario: A confirmation should not cancel out previous confirmation
Given a user is logged in as "johan"
And a klass: "10" exists with date: "2010-08-10"
And a teaching exists with klass: klass "10", teacher: user "prince", status_mask: 33
And a klass: "20" exists with date: "2010-08-20"
And a teaching exists with klass: klass "20", teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-18"
And I confirmed the klass
And I press "Confirm"
Then I should see "Successfully confirmed class(es)." as notice flash message
And I should be redirected to the already confirmed page for user: "prince"
And a teaching should exist with klass: klass "10", teacher: user "prince", status_mask: 33
And a teaching should exist with klass: klass "20", teacher: user "prince", status_mask: 33
And 2 teachings should exist

@decline
Scenario: Decline a class
Given a user is logged in as "johan"
And a klass exists with date: "2010-08-20"
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-18"
And I declined the klass
And I press "Confirm"
Then I should see "Successfully confirmed class(es)." as notice flash message
And I should be redirected to the already confirmed page for user: "prince"
And a teaching should exist with klass: that klass, teacher: user "prince", status_mask: 2
And 1 teachings should exist

@pending
Scenario: Check exeptions of classes that cannot be confirmed/declined

@pending
Scenario: Create expetion messages for those classes
# @confirm
# Scenario: Confirm & decline classes
# Given a course: "ruby" exists with name: "Ruby I"
# 	And a klass: "klass20" exists with date: "2010-03-20", course: course "ruby", start_time: "12:00", end_time: "13:00"
# 	And a klass: "klass19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
# 	And a klass: "klass18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
# 	And a teaching exists with klass: klass "klass20", teacher: user "prince"
# 	And a teaching exists with klass: klass "klass19", teacher: user "prince"

# 	And a teaching exists with klass: klass "klass18", teacher: user "prince"
# 	And a user is logged in as "prince"
# When I go to the confirm page for user: "prince" on "2010-03-06"
# 	And I confirmed klass "klass18" for user "prince" from "2010-03-06"
# 	And I declined klass "klass20" for user "prince" from "2010-03-06"
# 	And I press "Confirm"
# Then I should be redirected to path "/mypage"
# 	And I should see "Successfully confirmed class(es)." as notice flash message
# 	And a teaching should exist with klass: klass "klass18", teacher: user "prince", status_mask: 33
# 	And a teaching should exist with klass: klass "klass19", teacher: user "prince", status_mask: 4
# 	And a teaching should exist with klass: klass "klass20", teacher: user "prince", status_mask: 2
# 	And 3 teachings should exist
# 	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
# 	#And 1 mails should exist
# 	#And a recipient should exist with user: user "johan", mail: that mail
# 	#And 1 recipients should exist
