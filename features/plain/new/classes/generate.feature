Background:
Given a setting exist with name: "main"
	And a user: "johan" exist with username: "johan", role: "god, teacher", language: "en", name: "Johan Sveholm"
	
Scenario: Generate classes, that still not exists, for reservation
Given a template class exists with day: "mon"
	And a template class exists with day: "tue"
	And a template class exists with day: "wed"
	And a template class exists with day: "thu"
	And a template class exists with day: "thu"
	And a template class exists with day: "fri"
	And a template class exists with day: "sat"
	And a klass exists with date: "2010-03-11"
When I generate classes for reservation from "2010-03-08"
Then 1 klasses should exist with date: "2010-03-07 15"
	And 1 klasses should exist with date: "2010-03-08 15"
	And 1 klasses should exist with date: "2010-03-09 15"
	And 1 klasses should exist with date: "2010-03-10 15"
	And 1 klasses should exist with date: "2010-03-11 15"
	And 1 klasses should exist with date: "2010-03-12 15"
	And 6 klasses should exist

@pending
Scenario: Systematically spread out reservations according to level of the user (NOT IMPLEMENTED)
