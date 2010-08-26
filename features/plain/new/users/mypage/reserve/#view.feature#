
Background:
Given a setting exist with name: "main"
And a user: "reiko" exists with username: "reiko", role: "student, registrant", language: "en", name: "Reiko Arikawa"
And a user: "johan" exists with username: "johan", role: "god, registrant", language: "en", name: "Johan Sveholm"

@view @classes @days
Scenario Outline: View of the reserve page  when there are classes to reserve for different days
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/<date>(<day>) - Ruby I - 12:00~15:00"
Examples:
| date | day       |
|   15 | Monday    |
|   16 | Tuesday   |
|   17 | Wednesday |
|   18 | Thursday  |
|   19 | Friday    |
|   20 | Saturday  |

@no_classes
Scenario Outline: View of the reserve page when there are no classes to reserve
Given a course: "ruby" exists with name: "Ruby I"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-21", course: course "ruby"
And a klass exists with date: "2010-03-<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "You can do no reservations today."
Examples:
| date |
|   14 |
|   21 |

@days @admin
Scenario Outline: Reservations can only be made from Sat to Tue
Given a course: "ruby" exists with name: "Ruby I"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I go to the reserve page for user: "reiko" on "2010-03-<day>"
Then I should see "<view>"
Examples:
| day | view                                  |
|  03 | You can do no reservations today.     |
|  04 | You can do no reservations today.     |
|  05 | You can do no reservations today.     |
|  06 | 3/18(Thursday) - Ruby I - 12:00~15:00 |
|  07 | 3/18(Thursday) - Ruby I - 12:00~15:00 |
|  08 | 3/18(Thursday) - Ruby I - 12:00~15:00 |
|  09 | 3/18(Thursday) - Ruby I - 12:00~15:00 |

@2weeks
Scenario Outline: You can only reserve for 2 weeks ahead
Given a course: "ruby" exists with name: "Ruby I"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-11", course: course "ruby"
And a klass exists with date: "2010-03-18", course: course "ruby"
And a klass exists with date: "2010-03-25", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "<interval>"
Then I <week1> see "3/11(Thursday) - Ruby I - 12:00~15:00"
And I <week2> see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I <week3> see "3/25(Thursday) - Ruby I - 12:00~15:00"
Examples:
| interval     | week1      | week2      | week3      |
| 03/08～03/13 | should     | should not | should not |
| 03/15～03/20 | should not | should     | should not |
| 03/22～03/27 | should not | should not | should     |

@view @classes
Scenario: Regular view of the reserve page when there are classes to reserve
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "Reserve" as second title
And I should see "Classes to reserve"
And "03/15～03/20" should be selected in the "saturday" field
And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "Reservations can be made from Sat 12am to Tue 5pm."

@view @admin
Scenario: View of the reserve page for admin, weeks start with the latest week containing a class plus four weeks in the past
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-11", course: course "ruby"
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko"
Then the "saturday" field should have options "BLANK, 03/15～03/20, 03/08～03/13, 03/01～03/06, 02/22～02/27, 02/15～02/20"

@view @student
Scenario: View of the reserve page for students
Given a user is logged in as "reiko"
When I browse to the reserve page for user: "reiko"
Then I should see "Reserve" as second title
And I should not see a field "saturday"

@view @double
Scenario: Same class should not be displayed double
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should not see "3/18(Thursday) - Ruby I - 12:00~15:00 3/18(Thursday) - Ruby I - 12:00~13:00"

@view @date @admin
Scenario Outline: Change the week for admin
Given a course: "ruby" exists with name: "Ruby I"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
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

@multiple
Scenario: Classes should be displayed in order after day, time interval and only courses belonging to the user
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_student join model exists with course: "Ruby I", student: "johan"
And course: "ruby" is one of user: "reiko"'s student_courses
And a course: "rails" exists with name: "Rails II"
And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
And a klass exists with date: "2010-03-18", course: course "rails", start_time: "12:00", end_time: "13:00"
And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "11:00", end_time: "12:00"
And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "09:00", end_time: "13:00"
And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "17:00", end_time: "18:00"
And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00 3/19(Friday) - Ruby I - 09:00~13:00 3/19(Friday) - Ruby I - 12:00~13:00 3/20(Saturday) - Ruby I - 09:00~13:00 3/20(Saturday) - Ruby I - 17:00~18:00"

@no_classes
Scenario Outline: A course that is already reserved should not show up in the reservable section  
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "klass16-1" exists with date: "2010-03-18", course: course "ruby"
And a klass: "klass16-2" exists with date: "2010-03-18", course: course "ruby"
And an attendance exists with student: user "reiko", klass: klass "<klass>"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "You can do no reservations today."
Examples:
| klass     |
| klass16-1 |
| klass16-2 | 
