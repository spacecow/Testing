@view @reserve

Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "reiko" exists with username: "reiko", role: "student"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And a user: "johan" exists with username: "johan", role: "god"

@student @no_classes
Scenario: View of the reserve page for students
Given a user is logged in as "reiko"
When I go to the reserve page for user: "reiko"
Then I should see "Reserve" as second title
And I should not see a field "saturday"

@admin
Scenario: View of the reserve page for admin, weeks start with the latest week containing a class plus four weeks in the past
And a klass exists with date: "2010-03-11", course: course "ruby"
And a user is logged in as "johan"
When I go to the reserve page for user: "reiko"
Then the "saturday" field should have options "BLANK, 03/15～03/20, 03/08～03/13, 03/01～03/06, 02/22～02/27, 02/15～02/20"

@two_weeks
Scenario Outline: A student can only reserve for 2 weeks ahead
And a klass exists with date: "2010-03-11", course: course "ruby"
And a klass exists with date: "2010-03-25", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "<interval>"
Then I should <week1> "3/11(Thursday) - Ruby I - 12:00~15:00"
And I should <week2> "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should <week3> "3/25(Thursday) - Ruby I - 12:00~15:00"
Examples:
| interval     | week1   | week2   | week3   |
| 03/08～03/13 | see     | not see | not see |
| 03/15～03/20 | not see | see     | not see |
| 03/22～03/27 | not see | not see | see     |

@enrolled_courses
Scenario: A student can only reserve classes, which courses he is enrolled in
Given a course: "rails" exists with name: "Rails II"
And a klass exists with date: "2010-03-19", course: course "rails"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should not see "3/19(Friday) - Rails II - 12:00~15:00"

@student @already_reserved
Scenario: If a student has reserved a class, he can not reserve it again
Given an attendance exists with student: user "reiko", klass: klass "18"
And a user is logged in as "reiko"
When I go to the reserve page for user: "reiko" on "2010-03-06"
Then I should not see "3/18(Thursday) - Ruby I - 12:00~15:00"

@admin @already_reserved
Scenario: If a student has reserved a class, admin can still see it
Given an attendance exists with student: user "reiko", klass: klass "18"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then the "3/18(Thursday) - Ruby I - 12:00~15:00" checkbox should be checked

@admin @already_reserved @instance
Scenario: If a student has reserved a class, admin can still see it even if it has instances
Given an attendance exists with student: user "reiko", klass: klass "18"
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then the "3/18(Thursday) - Ruby I - 12:00~15:00" checkbox should be checked

@one_instance
Scenario: A student can only see one instance of the same class
Given a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should not see "3/18(Thursday) - Ruby I - 12:00~15:00 3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"

@sort
Scenario: Classes should be displayed in order after day and then time interval
Given a klass exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "11:00", end_time: "12:00"
And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "09:00", end_time: "13:00"
And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "17:00", end_time: "18:00"
And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00 3/18(Thursday) - Ruby I - 12:00~15:00 3/19(Friday) - Ruby I - 09:00~13:00 3/19(Friday) - Ruby I - 12:00~13:00 3/20(Saturday) - Ruby I - 09:00~13:00 3/20(Saturday) - Ruby I - 17:00~18:00"

@days
Scenario Outline: Reservations can only be made from Sat to Tue
And a user is logged in as "johan"
When I go to the reserve page for user: "reiko" on "2010-03-<day>"
Then I should see "<view>"
Examples:
| day | view                                               |
|  03 | Reservations can be made from Sat 12am to Tue 5pm. |
|  04 | Reservations can be made from Sat 12am to Tue 5pm. |
|  05 | Reservations can be made from Sat 12am to Tue 5pm. |
|  06 | 3/18(Thursday) - Ruby I - 12:00~15:00              |
|  07 | 3/18(Thursday) - Ruby I - 12:00~15:00              |
|  08 | 3/18(Thursday) - Ruby I - 12:00~15:00              |
|  09 | 3/18(Thursday) - Ruby I - 12:00~15:00              |

@no_time_jump
Scenario Outline: A regular student cannot jump in time
# #This is working during the test phase
# Given a user is logged in as "<user>"
# When I go to the reserve page for user: "reiko" on "2010-03-06"
# Then I should <view> "3/18(Thursday) - Ruby I - 12:00~15:00"
# Examples:
# | user  | view    |
# | johan | see     |
# | reiko | not see |

@days
Scenario Outline: View of the reserve page  when there are classes to reserve for different days
And a klass exists with date: "2010-03-<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/22～03/27"
Then I should see "3/<date>(<day>) - Ruby I - 12:00~15:00"
Examples:
| date | day       |
|   22 | Monday    |
|   23 | Tuesday   |
|   24 | Wednesday |
|   25 | Thursday  |
|   26 | Friday    |
|   27 | Saturday  |

@no_classes
Scenario Outline: View of the reserve page when there are no classes to reserve
Given a klass exists with date: "2010-03-28", course: course "ruby"
And a klass exists with date: "2010-03-<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/22～03/27"
Then I should see "You have no classes to reserve."
Examples:
| date |
|   21 |
|   28 |

@date
Scenario Outline: Change the week for admin
And a klass exists with date: "<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "<interval>"
Then I should see "<day> - Ruby I - 12:00~15:00"
And "<interval>" should be selected in the "saturday" field
Examples:
|       date | interval     | day            |
| 2010-03-18 | 03/15～03/20 | 3/18(Thursday) |
| 2010-03-11 | 03/08～03/13 | 3/11(Thursday) |
| 2010-03-04 | 03/01～03/06 | 3/4(Thursday)  |
| 2010-02-25 | 02/22～02/27 | 2/25(Thursday) |
| 2010-02-18 | 02/15～02/20 | 2/18(Thursday) |

@pending
Scenario: Put the include course in the controller instead of named scope
