@view
Background:
Given a setting exists with name: "main"
And a user: "reiko" exists with role: "student", username: "reiko"
And a user exists with username: "johan", role: "god" 

@teacher
Scenario Outline: A teacher should not have a reserve page
Given a user is logged in as "johan"
And a user exists with role: "teacher", name: "Prince Philip"
When I go to the <path> page for that user
Then I should see "Prince Philip is not a student."
Examples:
| path             |
| reserve          |
| already reserved |

@links
Scenario Outline: Links on the reserve page
Given a user is logged in as "reiko"
When I go to the <main_path> page for user: "reiko"
And I follow "<link>" within "#top_links"
Then I should be redirected to the <second_path> page for user: "reiko"
Examples:
| main_path        | link             | second_path      |
| reserve          | Reserve          | reserve          |
| reserve          | Already Reserved | already reserved |
| already reserved | Reserve          | reserve          |
| already reserved | Already Reserved | already reserved |

@allow-rescue
Scenario Outline: Regular students can only see their own reserve page
Given a user: "junko" exists with role: "student", username: "junko"
And a user is logged in as "junko"
When I go to the <path> page of user: "reiko"
Then I should be redirected to the reserve page of user: "junko"
Examples:
| path             |
| reserve          |
| already reserved |



