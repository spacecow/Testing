Background:
Given a setting exists with name: "main"
	And a user exists with username: "johan", role: "admin", language: "en"
	And a user is logged in as "johan"
	And a gallery: "Christmas" exists
	And a event exist with title_en: "Christmas Party", date: "2009-12-19", gallery: gallery "Christmas"

Scenario: Add a photo
When I go to the show page of gallery "Christmas"
  And I follow 'photos.add'
  And I press 'add'
Then I should see "Photo file name can't be blank"
When I attach the file at "C:/Pictures/00 233.jpg" to "Photo*"
  And I press 'add'
  And I press 'crop'
Then I should be redirected to the show page of that gallery
  And I should see "Successfully added photo."
  
#Scenario: Photo has already been uploaded
#Given a photo exists with photo_file_name: "C:/Pictures/00 233.jpg"
#When I go to the show page of gallery "Christmas"
#  And I follow 'photos.add'
#  And I attach the file at "C:/Pictures/00 233.jpg" to "Photo*"
#  And I press 'add'
#Then I should be redirected to the error photos page
#  And I should see "Photo file name has already been taken"
  
Scenario: Add caption to photo (NOT IMPLEMENTED)
Given not implemented