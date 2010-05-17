@photos
Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin", language: "en", name: "Johan Sveholm"
	And a user: "reiko" exists with username: "reiko", role: "registrant, photographer", language: "en", name: "Reiko Arikawa"
	And a gallery: "Christmas" exists
	And a event exist with title_en: "Christmas Party", start_date: "2009-12-19", gallery: gallery "Christmas"

@add_photo
Scenario Outline: Add a photo
Given a user is logged in as "<user>"
When I go to the show page of gallery "Christmas"
	And I follow 'photos.add'
  And I press "Add Photo"
Then I should see "Photo file name can't be blank"
When I attach the file at "C:/Pictures/sadako.jpg" to "Photo*"
  And I press "Add Photo"
  And I press 'crop'
Then I should be redirected to the show page of that gallery
  And I should see "Successfully added photo."
  And a photo should exist with user: user "<user>"
When I follow "sadako"
	Then I should see "By: <name>" within "div#uploader"
Examples:
| user 	|	name					|
| johan	|	Johan Sveholm	|
| reiko	|	Reiko Arikawa	|
  
Scenario: The same photo cannot be uploaded twice
Given a user is logged in as "johan"
When I go to the show page of gallery "Christmas"
	And I add a photo "sadako"
	And I follow "Add photo"  
  And I attach the file at "C:/Pictures/sadako.jpg" to "Photo"
  And I press "Add"
Then I should be redirected to the error photos page
  And I should see "Photo file name has already been taken"

@edit_photo	  
Scenario Outline: Make it optional to crop an already uploaded picture
Given a user is logged in as "<user>"
When I add a photo "sadako"
	And I follow "sadako"
	And I follow "Edit"
	And I check "edit_photo"
	And I press "Update"
  And I press "Crop"	
Then I should see "Successfully updated photo."
When I follow "sadako"
	And I follow "Edit"
	And I press "Update"
Then I should see "Successfully updated photo."
Examples:
| user	|
|	johan	|
|	reiko |

@delete_photo
Scenario Outline: Delete a photo
Given a user is logged in as "<user>"
When I add a photo "sadako"
	And I follow "sadako"
	And I follow "Del"
Then I should see "Successfully deleted photo."
	And 0 photos should exist
Examples:
| user	|
|	johan	|
|	reiko |

@anonymous
Scenario: If the uploader is deleted, his uploaded pictures should still exist
Given a user is logged in as "reiko"
	And I add a photo "sadako"
	And I follow "Logout"
	And a user is logged in as "johan"
When I go to the users page
	And I follow "Del" within user "reiko"
Then 1 photos should exist
When I go to the show page of gallery "Christmas"
	And I follow "sadako"
Then I should see "By: Anonymous" within "div#uploader"
	
@pending
Scenario: Set size for caption and uploader (NOT IMPLEMENTED)