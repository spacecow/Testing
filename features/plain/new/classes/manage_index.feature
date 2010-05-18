@index
Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	And a user: "aya" exist with username: "aya", role: "teacher, admin", language: "en", name: "Aya Komatsu"
	And a user: "prince" exist with username: "prince", role: "teacher, registrant", language: "en", name: "Prince Philip"
	And a user: "junko" exist with username: "junko", role: "student, registrant", language: "en", name: "Junko Sumii"

@not_current
Scenario: A teaching that is not active (current) does not interfere with other klasses when choosing teacher
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "prince"
	And a courses_teacher exists with course: course "rails", teacher: user "johan"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2011-02-28"
	And a klass: "rails" exists with course: course "rails", start_time: "18:50", end_time: "20:50", date: "2011-02-28"
	And a teaching exists with klass: klass "ruby", teacher: user "johan", current: false
	And a teaching exists with klass: klass "ruby", teacher: user "prince", current: true
	And a user is logged in as "aya"
When I browse to the klasses page of "February 28, 2011"
Then within klass: "ruby", "Prince Philip" should be selected as teacher
Then within klass: "rails", the teacher field should have options "BLANK, Johan Sveholm"

@teachers
Scenario: View of teachers according to what courses they can teach
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a courses_teacher exists with course: course "ruby", teacher: user "prince"
	And a courses_teacher exists with course: course "rails", teacher: user "johan"
	And a courses_teacher exists with course: course "rails", teacher: user "prince"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a klass: "rails" exists with course: course "rails", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a user is logged in as "aya"
When I browse to the klasses page of "February 28, 2010"
Then within klass: "ruby", the teacher field should have options "BLANK, Johan Sveholm, Aya Komatsu, Prince Philip"
	And within klass: "rails", the teacher field should have options "BLANK, Johan Sveholm, Prince Philip"
	And within klass: "ruby", "" should be selected as teacher
	And within klass: "rails", "" should be selected as teacher

@cost
Scenario: Cost for classes of 2 hours should be double
Given a course: "ruby1" exists with name: "Ruby I"
	And a course: "ruby2" exists with name: "Ruby II"
	And a courses_teacher exists with course: course "ruby1", teacher: user "johan", cost: "1500"
	And a courses_teacher exists with course: course "ruby2", teacher: user "aya", cost: "1500"
	And a klass: "ruby1" exists with course: course "ruby1", date: "2010-02-28", start_time: "10:00", end_time: "12:00"
	And a klass: "ruby2" exists with course: course "ruby2", date: "2010-02-28", start_time: "10:00", end_time: "10:50"
	And a user is logged in as "aya"
When I browse to the klasses page of "February 28, 2010"
	And I select "Aya Komatsu" as teacher within klass "ruby2"
	And I press "OK!" within klass "ruby2"
Then a teaching should exist with klass: klass "ruby2", teacher: user "aya", cost: "1500"
When I select "Johan Sveholm" as teacher within klass "ruby1"
	And I press "OK!" within klass "ruby1"
Then a teaching should exist with klass: klass "ruby1", teacher: user "johan", cost: "3000"	

@switch
Scenario: When switching teachers, the teaching should remain
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a klass: "ruby" exists with course: course "ruby", date: "2010-02-28"
	And a user is logged in as "aya"
Then 0 teachings should exist
When I browse to the klasses page of "February 28, 2010"
	And I select "Aya Komatsu" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then within klass: "ruby", "Aya Komatsu" should be selected as teacher
	And a teaching should exist with klass: klass "ruby", teacher: user "aya", current: true
	And 1 teachings should exist
When I select "Johan Sveholm" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then within klass: "ruby", "Johan Sveholm" should be selected as teacher
	And a teaching should exist with klass: klass "ruby", teacher: user "johan", current: true
	And a teaching should exist with klass: klass "ruby", teacher: user "aya", current: false
	And 2 teachings should exist
When I select "Aya Komatsu" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
And 2 teachings should exist
	And a teaching should exist with klass: klass "ruby", teacher: user "johan", current: false
	And a teaching should exist with klass: klass "ruby", teacher: user "aya", current: true
Then within klass: "ruby", "Aya Komatsu" should be selected as teacher

@double
Scenario: Teachers cannot teach more than one class at the same time
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a klass: "ruby2" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a user is logged in as "aya"
Then 0 teachings should exist
When I browse to the klasses page of "February 28, 2010"
	And I select "Aya Komatsu" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "ruby", teacher: user "aya"
	And 1 teachings should exist
	And within klass: "ruby", the teacher field should have options "BLANK, Johan Sveholm, Aya Komatsu"
	And within klass: "ruby2", the teacher field should have options "BLANK, Johan Sveholm"
	And within klass: "ruby", "Aya Komatsu" should be selected as teacher
	And within klass: "ruby2", "" should be selected as teacher

@deleting
Scenario: When deleting a class that has teachings, the teachings should be deleted
Given a course: "ruby" exists with name: "Ruby II"
	And a klass: "ruby" exists with course: course "ruby", date: "2011-02-28"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a teaching exists with klass: klass "ruby", teacher: user "aya", current: false
	And a teaching exists with klass: klass "ruby", teacher: user "johan", current: true
	And a user is logged in as "aya"
Then 2 teachings should exist
When I browse to the klasses page of "February 28, 2011"
	And I follow "Del" within "table#Ruby tr td#links"
Then 0 teachings should exist

@extended_double
Scenario: Teachers cannot teach more than one class at the same time
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a course: "fortran" exists with name: "Fortran III"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a courses_teacher exists with course: course "ruby", teacher: user "aya"
	And a courses_teacher exists with course: course "ruby", teacher: user "prince"
	And a courses_teacher exists with course: course "rails", teacher: user "johan"
	And a courses_teacher exists with course: course "rails", teacher: user "prince"
	And a courses_teacher exists with course: course "fortran", teacher: user "aya"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a klass: "ruby2" exists with course: course "ruby", start_time: "21:00", end_time: "23:00", date: "2010-02-28"
	And a klass: "rails" exists with course: course "rails", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a klass: "fortran" exists with course: course "fortran", start_time: "21:00", end_time: "23:00", date: "2010-02-28"
	And a klass: "fortran2" exists with course: course "fortran", start_time: "22:00", end_time: "23:30", date: "2010-02-28"
	And a user is logged in as "aya"
Then 0 teachings should exist
When I browse to the klasses page of "February 28, 2010"
	And I select "Aya Komatsu" as teacher within klass "fortran"
	And I press "OK!" within klass "fortran"
Then a teaching should exist with klass: klass "fortran", teacher: user "aya"
	And 1 teachings should exist
	And within klass: "ruby", the teacher field should have options "BLANK, Johan Sveholm, Aya Komatsu, Prince Philip"
	And within klass: "ruby2", the teacher field should have options "BLANK, Johan Sveholm, Prince Philip"
	And within klass: "rails", the teacher field should have options "BLANK, Johan Sveholm, Prince Philip"
	And within klass: "fortran", the teacher field should have options "BLANK, Aya Komatsu"
	And within klass: "fortran2", the teacher field should have options "BLANK"
	And within klass: "ruby", "" should be selected as teacher
	And within klass: "ruby2", "" should be selected as teacher
	And within klass: "rails", "" should be selected as teacher
	And within klass: "fortran", "Aya Komatsu" should be selected as teacher
	And within klass: "fortran2", "" should be selected as teacher
When I select "Johan Sveholm" as teacher within klass "ruby"
	And I press "OK!" within klass "ruby"
Then a teaching should exist with klass: klass "fortran", teacher: user "aya"
	And a teaching should exist with klass: klass "ruby", teacher: user "johan"
	And 2 teachings should exist	
Then within klass: "ruby", the teacher field should have options "BLANK, Johan Sveholm, Aya Komatsu, Prince Philip"
	And within klass: "ruby2", the teacher field should have options "BLANK, Johan Sveholm, Prince Philip"
	And within klass: "rails", the teacher field should have options "BLANK, Prince Philip"
	And within klass: "fortran", the teacher field should have options "BLANK, Aya Komatsu"
	And within klass: "fortran2", the teacher field should have options "BLANK"
	And within klass: "ruby", "Johan Sveholm" should be selected as teacher
	And within klass: "ruby2", "" should be selected as teacher
	And within klass: "rails", "" should be selected as teacher
	And within klass: "fortran", "Aya Komatsu" should be selected as teacher
	And within klass: "fortran2", "" should be selected as teacher
When I select "Prince Philip" as teacher within klass "ruby2"
	And I press "OK!" within klass "ruby2"
	And a teaching should exist with klass: klass "fortran", teacher: user "aya"
	And a teaching should exist with klass: klass "ruby", teacher: user "johan"
	And a teaching should exist with klass: klass "ruby2", teacher: user "prince"
	And 3 teachings should exist		
Then within klass: "ruby", the teacher field should have options "BLANK, Johan Sveholm, Aya Komatsu, Prince Philip"
	And within klass: "ruby2", the teacher field should have options "BLANK, Johan Sveholm, Prince Philip"
	And within klass: "rails", the teacher field should have options "BLANK, Prince Philip"
	And within klass: "fortran", the teacher field should have options "BLANK, Aya Komatsu"
	And within klass: "fortran2", the teacher field should have options "BLANK"
	And within klass: "ruby", "Johan Sveholm" should be selected as teacher
	And within klass: "ruby2", "Prince Philip" should be selected as teacher
	And within klass: "rails", "" should be selected as teacher
	And within klass: "fortran", "Aya Komatsu" should be selected as teacher
	And within klass: "fortran2", "" should be selected as teacher
When I select "Prince Philip" as teacher within klass "rails"
	And I press "OK!" within klass "rails"
	And a teaching should exist with klass: klass "fortran", teacher: user "aya"
	And a teaching should exist with klass: klass "ruby", teacher: user "johan"
	And a teaching should exist with klass: klass "ruby2", teacher: user "prince"
	And a teaching should exist with klass: klass "rails", teacher: user "prince"
	And 4 teachings should exist			
Then within klass: "ruby", the teacher field should have options "BLANK, Johan Sveholm, Aya Komatsu"
	And within klass: "ruby2", the teacher field should have options "BLANK, Johan Sveholm, Prince Philip"
	And within klass: "rails", the teacher field should have options "BLANK, Prince Philip"
	And within klass: "fortran", the teacher field should have options "BLANK, Aya Komatsu"
	And within klass: "fortran2", the teacher field should have options "BLANK"
	And within klass: "ruby", "Johan Sveholm" should be selected as teacher
	And within klass: "ruby2", "Prince Philip" should be selected as teacher
	And within klass: "rails", "Prince Philip" should be selected as teacher
	And within klass: "fortran", "Aya Komatsu" should be selected as teacher
	And within klass: "fortran2", "" should be selected as teacher

@generate
Scenario Outline: When choosing a date that does not have any classes, they should be generated if the user is admin
Given a course: "ruby" exists with name: "Ruby II"
	And a classroom: "1" exists with name: "1"
	And a template class: "ruby" exists with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "sun"
Given a user is logged in as "<user>"
When I browse to the klasses page of "March 28, 2010"
Then 1 klasses should exist with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, cancel: false, description: "A funny description", note: "A funny note", date: "2010-03-27 15"
	And 1 klasses should exist
	And I should see options "Info, Edit, Del" within "table#Ruby tr td#links"
Examples:
|	user	|
| johan	|
| aya		|

@allow-rescue
Scenario: Registrants cannot reach the list of classes
Given a user: "mika" exists with username: "mika", role: "registrant", language: "en", name: "Mika Mikachan"
	And a user is logged in as "mika"
When I go to the klasses page
Then I should be redirected to the events page

Scenario Outline: When choosing a date that does not have any classes, no classes will be generated if the user is student/teacher/observer
Given a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
Given a course: "ruby" exists with name: "Ruby II"
	And a classroom: "1" exists with name: "1"
	And a template class: "ruby" exists with course: course "ruby", classroom: classroom "1", start_time: "18:50", end_time: "20:50", title: "A funny title", capacity: 8, mail_sending: 0, inactive: false, description: "A funny description", note: "A funny note", day: "sun"
Given a user is logged in as "<user>"
When I browse to the klasses page of "March 28, 2010"
Then 0 klasses should exist
Examples:
|	user			|
| prince		|
| junko			|
| thomas		|
|	reiko			|

@observer
Scenario Outline: List classes for observer/student/teacher
Given a course: "ruby" exists with name: "Ruby I"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a user: "thomas" exists with username: "thomas", role: "observer, teacher", language: "en", name: "Thomas Osburg"
	And a user: "reiko" exists with username: "reiko", role: "registrant, student, beta-tester", language: "en", name: "Reiko Arikawa"
	And a user is logged in as "<user>"
Then 1 klasses should exist
When I browse to the klasses page of "February 28, 2010"
Then I should see options "Info" within "table#Ruby tr td#links"
	And 1 klasses should exist
Examples:
|	user			|
| prince		|
| junko			|
| thomas		|
|	reiko			|

@display_date
Scenario: Classes display of date
Given a user is logged in as "johan"
When I go to the klasses page
Then "menu_month" should have options "January, February, March, April, May, June, July, August, September, October, November, December"
	And "menu_day" should have options "1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31"
	And "menu_year" should have options "2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020"
	And "menu_month" should have no blank option	
	And "menu_day" should have no blank option	
	And "menu_year" should have no blank option		
When I select "February 15, 2012" as date in the select menu
	And I press "Go!"
Then I should be redirected to the klasses page
	And I should see "Classes - Wednesday" within "h1"
 	And "February 15, 2012" should be selected as date in the select menu

Scenario: List classes according to day
Given a course: "ruby" exists with name: "Ruby I"
	And a course: "rails" exists with name: "Rails II"
	And a klass: "ruby" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2010-02-28"
	And a klass: "rails" exists with course: course "rails", start_time: "12:00", end_time: "13:00", date: "2010-03-01"
	And a user is logged in as "johan"
When I browse to the klasses page of "February 28, 2010"
Then I should see "I" within "table#Ruby tr td.course_level"
	And I should see "18:50~20:50" within "table#Ruby tr td#time_interval"
	And I should see "" within "table#Ruby tr td#unit"
	And I should see "" within "table#Ruby tr td#classroom"
	And I should see "" within "table#Ruby tr td#teacher"
	And I should see options "Info, Edit, Del" within "table#Ruby tr td#links"
	And I should not see "Rails"
When I select "March 1, 2010" as date in the select menu
	And I press "Go!"
	And I should see "II" within "table#Rails tr td.course_level"
	And I should see "12:00~13:00" within "table#Rails tr td#time_interval"	
	And I should see "" within "table#Rails tr td#unit"
	And I should see "" within "table#Rails tr td#classroom"
	And I should see "" within "table#Rails tr td#teacher"
	And I should see options "Info, Edit, Del" within "table#Rails tr td#links"
	And I should not see "Ruby"

@index_links
Scenario Outline: Check that the date is correct in the form when creating a new class
Given a user is logged in as "johan"
When I browse to the klasses page of "<month> <day>, <year>"
	And I follow "New Class" within "div#list div#links"
Then I should be redirected to the new klass page
	And "<month> <day>, <year>" should be selected as klass date
	And "klass_date_1i" should have no blank option	
	And "klass_date_2i" should have no blank option	
	And "klass_date_3i" should have no blank option	
Examples:
|	year	|	month			|	day	|
|	2012	|	February	|	15	|
|	2020	|	December	|	1		|
|	2010	|	January		|	31	|

@links
Scenario: Links from index page
Given a course exists with name: "Rails II"
	And a course exists with name: "Ruby II"
	And a course: "ruby1" exists with name: "Ruby I"
	And a klass exists with course: course "ruby1", start_time: "18:50", end_time: "20:50", date: "2010-02-28", capacity: 6
	And a user is logged in as "johan"
Then 1 klasses should exist
When I browse to the klasses page of "February 28, 2010"
	And I follow "Info" within "table#Ruby tr td#links"
Then I should be redirected to the show page of that klass
When I browse to the klasses page of "February 28, 2010"
	And I follow "Edit" within "table#Ruby tr td#links"
Then I should be redirected to the edit page of that klass

@new
Scenario: When creating a new class the categories should stay fixed
Given a course exists with name: "Rails II", capacity: 6
	And a course: "ruby2" exists with name: "Ruby II", capacity: 6
	And a course: "ruby1" exists with name: "Ruby I", capacity: 8
	And a user is logged in as "johan"
When I go to the klasses page
	And I follow "New Class" within "div#list div#links"
Then I should be redirected to the new klass page
	And the "Course" field should have options "BLANK, Ruby I (8), Ruby II (6), Rails II (6)"
When I press "Create"
Then I should be redirected to the error klasses page
	And the "Course" field should have options "BLANK, Ruby I (8), Ruby II (6), Rails II (6)"
When I press "Create"
Then I should be redirected to the error klasses page
	And the "Course" field should have options "BLANK, Ruby I (8), Ruby II (6), Rails II (6)"	

@similar
Scenario: When creating a class in the same category, the categories should stay fixed
Given a course exists with name: "Rails II", capacity: 6
	And a course: "ruby2" exists with name: "Ruby II", capacity: 6
	And a course: "ruby1" exists with name: "Ruby I", capacity: 8
	And a klass exists with course: course "ruby1", start_time: "18:50", end_time: "20:50", capacity: 6, date: "2011-02-28"
	And a user is logged in as "johan"
When I browse to the klasses page of "February 28, 2011"
	And I follow "+" within "table#Ruby"
Then I should be redirected to the new klass page
	And "February 28, 2011" should be selected as klass date
	And the "Course" field should have options "BLANK, Ruby I (8), Ruby II (6)"
	And the "Start time" field should be empty
	And the "End time" field should be empty
When I press "Create"
Then I should be redirected to the error klasses page
	And "February 28, 2011" should be selected as klass date
	And the "Course" field should have options "BLANK, Ruby I (8), Ruby II (6)"
When I press "Create"
Then I should be redirected to the error klasses page
	And "February 28, 2011" should be selected as klass date
	And the "Course" field should have options "BLANK, Ruby I (8), Ruby II (6)"	

@duplicate
Scenario: Duplicate a class
Given a course: "ruby" exists with name: "Ruby I"
	And a klass exists with course: course "ruby", start_time: "18:50", end_time: "20:50", capacity: 6, date: "2011-02-28"
	And a user is logged in as "johan"
When I browse to the klasses page of "February 28, 2011"
	And I follow "+" within that klass
Then I should automatically browse to the klasses page of "February 28, 2011"
	And 2 klasses should exist with course: course "ruby", start_time: "18:50", end_time: "20:50", capacity: 6, date: "2011-02-27 15"
	And 2 klasses should exist

@declined
Scenario: A teacher that has declined his class should be able to teach another class at the same time
Given a course: "ruby" exists with name: "Ruby I"
	And a courses_teacher exists with course: course "ruby", teacher: user "johan"
	And a klass: "ruby1" exists with course: course "ruby", start_time: "18:50", end_time: "20:50", date: "2011-02-28"
	And a klass: "ruby2" exists with course: course "ruby", start_time: "19:00", end_time: "21:00", date: "2011-02-28"
	And a teaching exists with klass: klass "ruby1", teacher: user "johan", status_mask: 2, current: true
	And a user is logged in as "johan"
When I browse to the klasses page of "February 28, 2011"
Then within klass: "ruby1", the teacher field should have options "BLANK, Johan Sveholm"
	And within klass: "ruby1", "Johan Sveholm" should be selected as teacher
	And within klass: "ruby2", the teacher field should have options "BLANK, Johan Sveholm"

@pending
Scenario: Not be able to delete a class with students (NOT IMPLEMENTED)

@pending
Scenario: Implement versioning? (NOT IMPLEMENTED)

@pending
Scenario: Should be able to delete teaching (NOT IMPLEMENTED)

@pending
Scenario: Test to drop the ok buttons if javascript is turned on (NOT IMPLEMENTED)