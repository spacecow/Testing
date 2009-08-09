Given /^the following courses student records?$/ do |table|
	table.hashes.each do |hash|
		Factory( :courses_student,hash )
	end
end