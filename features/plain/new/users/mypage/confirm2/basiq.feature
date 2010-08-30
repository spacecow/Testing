Background:
Given a setting exist with name: "main"
And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
And a user: "aya" exist with username: "aya", role: "admin, teacher", language: "en", name: "Aya Komatsu"
And a user: "prince" exist with username: "prince", role: "registrant, teacher", language: "en", name: "Prince Philip"

@pending
Scenario: Links on confirmation page (NOT IMPLEMENTED)

@view @confirmable
Scenario Outline: View of classes that can be confirmed
Given a klass: "04" exists with date: "2010-03-04"
Given a klass: "18" exists with date: "2010-03-18"
Given a klass: "19" exists with date: "2010-03-19"
And a teaching exists with klass: klass "04", teacher: user "prince", status_mask: 4
And a teaching exists with klass: klass "18", teacher: user "prince", status_mask: <status>
And a teaching exists with klass: klass "19", teacher: user "johan", status_mask: 4
And a user is logged in as "johan"
When I browse to the confirm page for user: "prince" for "03/15～03/20"
Then I should not see "3/4(Thursday)"
And I should <view> "3/18(Thursday)"
And I should not see "3/19(Friday)"
Examples:
| status | view    |
|      4 | see     |
|     33 | not see |
|      2 | not see |
|      9 | not see |
|     17 | not see |

@view @confirmed
Scenario Outline: View of confirmed classes
Given a klass: "04" exists with date: "2010-03-04"
Given a klass: "18" exists with date: "2010-03-18"
Given a klass: "19" exists with date: "2010-03-19"
And a teaching exists with klass: klass "04", teacher: user "prince", status_mask: 33
And a teaching exists with klass: klass "18", teacher: user "prince", status_mask: <status>
And a teaching exists with klass: klass "19", teacher: user "johan", status_mask: 33
Given a user is logged in as "johan"
When I browse to the already confirmed page for user: "prince" for "03/15～03/20"
Then I should not see "3/4(Thursday)"
And I should <view> "3/18(Thursday)"
And I should not see "3/19(Friday)"
Examples:
| status | view    |
|      4 | not see |
|     33 | see     |
|      2 | not see |
|      9 | see     |
|     17 | see     |

@view @history
Scenario Outline: View of confirm history
Given a klass: "18" exists with date: "2010-03-18"
Given a klass: "19" exists with date: "2010-03-19"
Given a klass: "29" exists with date: "2010-03-29"
And a teaching exists with klass: klass "18", teacher: user "prince", status_mask: <status>
And a teaching exists with klass: klass "19", teacher: user "johan", status_mask: 33
And a teaching exists with klass: klass "29", teacher: user "prince", status_mask: 33
Given a user is logged in as "johan"
When I browse to the confirm history page for user: "prince" for "03/29～04/03"
And I should <view> "3/18(Thursday)"
And I should not see "3/19(Friday)"
And I should not see "3/29(Monday)"
Examples:
| status | view    |
|      4 | not see |
|     33 | see     |
|      2 | not see |
|      9 | see     |
|     17 | see     |

@pending
Scenario: Only show classes that have been confirmed taught in the history? (NOT IMPLEMENTED)

@allow-rescue
Scenario Outline: Regular teachers can only see their own confiration page, but admins have no limit
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher"
And a user is logged in as "<user>"
When I browse to the confirm page for user: "<user>"
Then I should be redirected to the <own-page>
When I browse to the confirm page for user: "thomas"
Then I should be redirected to the <other-page>
Examples:
| user   | own-page                     | other-page                      |
| thomas | show page for user: "thomas" | show page for user: "thomas"    |
| prince | show page for user: "prince" | show page for user: "prince"    |
| johan  | show page for user: "johan"  | show page for user: "thomas" |
| aya    | show page for user: "aya"    | show page for user: "thomas" |

@pending
Scenario: Classes should be displayed in order after day, time interval
#Given a course: "ruby" exists with name: "Ruby I"
#	And a klass: "klass19-2" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
#	And a klass: "klass18-2" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
#	And a klass: "klass18-1" exists with date: "2010-03-18", course: course "ruby", start_time: "11:00", end_time: "12:00"
#	And a klass: "klass20-1" exists with date: "2010-03-20", course: course "ruby", start_time: "09:00", end_time: "13:00"
#	And a klass: "klass20-2" exists with date: "2010-03-20", course: course "ruby", start_time: "17:00", end_time: "18:00"
#	And a klass: "klass19-1" exists with date: "2010-03-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
#	And a teaching exists with klass: klass "klass19-2", teacher: user "johan"
#	And a teaching exists with klass: klass "klass18-2", teacher: user "johan"
#	And a teaching exists with klass: klass "klass18-1", teacher: user "johan"
#	And a teaching exists with klass: klass "klass20-1", teacher: user "johan"
#	And a teaching exists with klass: klass "klass20-2", teacher: user "johan"
#	And a teaching exists with klass: klass "klass19-1", teacher: user "johan"	
#	And a user is logged in as "johan"
#When I go to the confirm page for user: "johan" on "2010-03-06"
#Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00, 3/18(Thursday) - Ruby I - 12:00~13:00, 3/19(Friday) - Ruby I - 09:00~13:00, 3/19(Friday) - Ruby I - 12:00~13:00, 3/20(Saturday) - Ruby I - 09:00~13:00, 3/20(Saturday) - Ruby I - 17:00~18:00" within "div.confirmable"

@confirm
Scenario: Confirm & decline classes
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "klass20" exists with date: "2010-03-20", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass19" exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a klass: "klass18" exists with date: "2010-03-18", course: course "ruby", start_time: "12:00", end_time: "13:00"
	And a teaching exists with klass: klass "klass20", teacher: user "prince"
	And a teaching exists with klass: klass "klass19", teacher: user "prince"
	And a teaching exists with klass: klass "klass18", teacher: user "prince"
	And a user is logged in as "prince"
When I go to the confirm page for user: "prince" on "2010-03-06"
	And I confirmed klass "klass18" for user "prince" from "2010-03-06"
	And I declined klass "klass20" for user "prince" from "2010-03-06"
	And I press "Confirm"
Then I should be redirected to path "/mypage"
	And I should see "Successfully confirmed class(es)." as notice flash message
	And a teaching should exist with klass: klass "klass18", teacher: user "prince", status_mask: 33
	And a teaching should exist with klass: klass "klass19", teacher: user "prince", status_mask: 4
	And a teaching should exist with klass: klass "klass20", teacher: user "prince", status_mask: 2
	And 3 teachings should exist
	#And a mail should exist with subject: "Reservation", message: "You have reserved a class!"
	#And 1 mails should exist
	#And a recipient should exist with user: user "johan", mail: that mail
	#And 1 recipients should exist

@confirm_again
Scenario: Check that already class history does not get erased when a new class is confirmed
Given a klass: "klass04" exists with date: "2010-03-04"
	And a klass: "klass05" exists with date: "2010-03-05"
	And a klass: "klass18" exists with date: "2010-03-18"
	And a klass: "klass19" exists with date: "2010-03-19"
	And a klass: "klass20" exists with date: "2010-03-20"
	And a klass: "klass21" exists with date: "2010-03-21"
	And a teaching exists with klass: klass "klass04", teacher: user "prince", status_mask: 33
	And a teaching exists with klass: klass "klass05", teacher: user "prince", status_mask: 2
	And a teaching exists with klass: klass "klass18", teacher: user "prince", status_mask: 4
	And a teaching exists with klass: klass "klass19", teacher: user "prince", status_mask: 4
	And a teaching exists with klass: klass "klass20", teacher: user "prince", status_mask: 33
	And a teaching exists with klass: klass "klass21", teacher: user "prince", status_mask: 2
	And a user is logged in as "prince"
Then 6 teachings should exist
When I go to the confirm page for user: "prince" on "2010-03-10"
Then I should see "3/18(Thursday)" within "div.confirmable"
	And I should see "3/19(Friday)" within "div.confirmable"
	And I should see "3/20(Saturday)" within "div.confirmed"
	And I should see "3/4(Thursday)" within "div.taught"
	And I should see "3/5(Friday)" within "div.declined"
	And I should see "3/21(Sunday)" within "div.declined"
When I confirmed klass "klass19" for user "prince" from "2010-03-10"
	And I press "Confirm"
Then I should be redirected to path "/mypage"
	And I should see "Successfully confirmed class(es)." as notice flash message
	And a teaching should exist with klass: klass "klass04", teacher: user "prince", status_mask: 33
	And a teaching should exist with klass: klass "klass05", teacher: user "prince", status_mask: 2
	And a teaching should exist with klass: klass "klass18", teacher: user "prince", status_mask: 4
	And a teaching should exist with klass: klass "klass19", teacher: user "prince", status_mask: 33
	And a teaching should exist with klass: klass "klass20", teacher: user "prince", status_mask: 33
	And a teaching should exist with klass: klass "klass21", teacher: user "prince", status_mask: 2
	And 6 teachings should exist
	
@not_current
Scenario: If a teaching is not current it should not appear
Given a klass: "klass18" exists with date: "2010-03-18"
	And a klass: "klass19" exists with date: "2010-03-19"
	And a klass: "klass20" exists with date: "2010-03-20"
	And a teaching exists with klass: klass "klass18", teacher: user "johan", current: true
	And a teaching exists with klass: klass "klass19", teacher: user "johan", current: false
	And a teaching exists with klass: klass "klass20", teacher: user "johan", current: true
Given a user is logged in as "johan"
When I go to the confirm page for user: "johan" on "2010-03-06"
	And I should see "3/18(Thursday)" within "div.confirmable"
	#And I should not see "3/19(Friday)" within the form
	And I should see "3/20(Saturday)" within "div.confirmable"
	
@pending
Scenario: Two teachings should not be able to be current at the same time (NOT IMPLEMENTED)

@pending
Scenario: Declined classes are usually NOT current (NOT IMPLEMENTED) see @not_current
