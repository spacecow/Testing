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
	And a klass exists with date: "2010-03-18"
When I generate classes for reservation from "2010-03-15"
Then 6 klasses should exist

Scenario: Systematically spread out reservations according to level of the user (NOT IMPLEMENTED)
Given not implemented