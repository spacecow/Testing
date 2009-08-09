When /^I try to delete teacher "([^\"]*)"$/ do |user|
	post "/people/destroy", :id => Person.find_by_user_name( user ).id
	# Selenium
	# fill in "Search" with " "
end

def find_teacher( user )
	Teacher.first(
		:conditions=>["people.user_name=?", user],
		:include=>:person )
end
