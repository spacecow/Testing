Given /^I add a photo "([^\"]*)"$/ do |photo|	
	Given "I go to the show page of that gallery"
	And "I follow 'photos.add'"
  And "I attach the file at \"C:/Pictures/#{photo}.jpg\" to 'photo'"
  And "I press \"Add Photo\""
  And "I press 'crop'"
end

Given /^I add a photo "([^\"]*)" in Japanese$/ do |photo|	
	Given "I go to the show page of that gallery"
	And "I follow 'photos.add'"
  And "I attach the file at \"C:/Pictures/#{photo}.jpg\" to 'photo'"
  And "I press \"写真を書き足す\""
  And "I press 'crop'"
end