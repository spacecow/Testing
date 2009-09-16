Given /^I have schedule "([^\"]*)"$/ do |titles|
  titles.split(', ').each do |title|
  	Schedule.create!( :course_id => Course.find_by_name( title ).id )
  end
end

When /^I follow '([^\"]*)' for schedule "([^\"]*)"$/ do |link,schedule|
	within '.'+schedule.gsub( / /,'_' ) do
		click_link I18n.translate( link )
	end
end