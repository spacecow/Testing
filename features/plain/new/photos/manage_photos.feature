Background:
Given a setting exists with name: "main"
	And a user: "johan" exists with username: "johan", role: "admin", language: "en"
	And a user: "reiko" exists with username: "reiko", role: "registrant, photographer", language: "en"
	And a gallery: "Christmas" exists
	And a event exist with title_en: "Christmas Party", start_date: "2009-12-19", gallery: gallery "Christmas"

@add_photo
Scenario Outline: Add a photo
Given a user is logged in as "<user>"
When I go to the show page of gallery "Christmas"
	And I follow 'photos.add'
  And I press "Add Photo"
Then I should see "Photo file name can't be blank"
When I attach the file at "C:/Pictures/00 233.jpg" to "Photo*"
  And I press "Add Photo"
  And I press 'crop'
Then I should be redirected to the show page of that gallery
  And I should see "Successfully added photo."
  And a photo should exist with user: user "<user>"
Examples:
| user 	|
| johan	|
| reiko	|
  
#Scenario: Photo has already been uploaded
#Given a photo exists with photo_file_name: "C:/Pictures/00 233.jpg"
#When I go to the show page of gallery "Christmas"
#  And I follow 'photos.add'
#  And I attach the file at "C:/Pictures/00 233.jpg" to "Photo*"
#  And I press 'add'
#Then I should be redirected to the error photos page
#  And I should see "Photo file name has already been taken"

@edit_photo	  
Scenario Outline: Make it optional to crop an already uploaded picture
Given a user is logged in as "<user>"
When I go to the show page of gallery "Christmas"
	And I follow "Add Photo"
	And I attach the file at "C:/Pictures/sadako.jpg" to "Photo"
  And I press "Add"
  And I press "Crop"
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

