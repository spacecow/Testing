Given /^I add a photo "([^\"]*)"$/ do |photo|	
	Given "I go to the show page of that gallery"
	And "I follow 'photos.add'"
  And "I attach the file at \"C:/Pictures/#{photo}.jpg\" to 'photo'"
  And "I press 'add'"
  And "I press 'crop'"
end