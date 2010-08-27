Background:
Given a setting exists with name: "main"

@reserve @view
Scenario Outline: Display for users
Given a user: "<name>" exists with username: "<name>", role: "<role>", language: "en"
And a user is logged in as "<name>"
When I go to the show page of user "<name>"
Then I should <reserve> a button labeled "Reserve"
And I should <confirm> a button labeled "Confirm"
Examples:
| name   | role                         | reserve | confirm |
| mika   | registrant                   | not see | not see |
| reiko  | registrant, student          | see     | not see |
| prince | registrant, teacher          | not see | see     |
| adrian | registrant, student, teacher | see     | see     |

@reserve @view @admin
Scenario Outline: Reserve&Confirm should only be shown if the user is a student&teacher
Given a user: "johan" exists with username: "johan", role: "god, registrant", language: "en"
Given a user: "<name>" exists with username: "<name>", role: "<role>", language: "en"
And a user is logged in as "johan"
When I go to the show page of user "<name>"
Then I should <reserve> a button labeled "Reserve"
And I should <confirm> a button labeled "Confirm"
Examples:
| name   | role                         | reserve | confirm |
| mika   | registrant                   | not see | not see |
| reiko  | registrant, student          | see     | not see |
| prince | registrant, teacher          | not see | see     |
| adrian | registrant, student, teacher | see     | see     |

@actions @student
Scenario Outline: Actions for student
Given a user exists with username: "reiko", role: "student, registrant", language: "en"
And a user is logged in as "reiko"
When I go to the show page of that user
And I press "<button>"
Then the page should have a "<section>" section
And I should see "<button>" as second title
Examples:
| button                 | section          |
| Reserve                | reservable       |
| Already Reserved       | already_reserved |
| History of Reservation | reserve_history  |

@actions @teacher
Scenario Outline: Actions for teacher
Given a user exists with username: "prince", role: "registrant, teacher", language: "en"
And a user is logged in as "prince"
When I go to the show page of that user
And I press "<button>"
Then the page should have a "<section>" section
And I should see "<button>" as second title
Examples:
| button                  | section           |
| Confirm                 | confirmable       |
| Already Confirmed       | already_confirmed |
| History of Confirmation | confirm_history   |

@allow-rescue
Scenario Outline: Regular users can only see their own reservation page, but admins have no limit
Given a user: "johan" exists with username: "johan", role: "god, registrant"
And a user: "aya" exists with username: "aya", role: "admin, registrant"
And a user: "junko" exists with username: "junko", role: "registrant, student"
And a user: "mika" exists with username: "mika", role: "registrant"
And a user: "reiko" exist with username: "reiko", role: "registrant, student"
And a user: "prince" exists with username: "prince", role: "registrant, teacher"
And a user is logged in as "<user>"
When I go to the show page for user: "<user>"
Then I should be redirected to the <own-page>
When I go to the show page for user: "prince"
Then I should be redirected to the <other-page>
Examples:
| user  | own-page                    | other-page                      |
| junko | show page for user: "junko" | events page                     |
| mika  | show page for user: "mika"  | events page                     |
| reiko | show page for user: "reiko" | events page                     |
| aya   | show page for user: "aya"   | show page for user: "prince" |
| johan | show page for user: "johan" | show page for user: "prince" |

@default
Scenario Outline: The default page should be Reserve&Confirm
Given a user exists with username: "<user>", role: "<role>"
And a user is logged in as "<user>"
Then the page should have a "<section>" section
Examples:
| user   | role    | section     |
| reiko  | student | reservable  |
| prince | teacher | confirmable |



@pending
Scenario: Links on reservation page (NOT IMPLEMENTED)

@pending
Scenario: Include time, 12 from sat to 17 on tue (NOT IMPLEMENTED)

@pending
Scenario: Implement mailing (NOT IMPLEMENTED)
