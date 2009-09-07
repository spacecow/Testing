Given /^I have schedule "([^\"]*)"$/ do |titles|
  titles.split(', ').each do |title|
  	Schedule.create!( :title => title )
  end
end