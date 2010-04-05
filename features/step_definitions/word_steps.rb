When /^I generate the word database from file "([^\"]*)"$/ do |file|
  Word.generate_database( "data/#{file}" )
end
