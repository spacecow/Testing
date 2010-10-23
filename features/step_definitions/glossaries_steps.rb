Given /(\w+) "(.+)" are #{capture_model}'s (\w+)/ do |model, names, owner, assoc| #'
  names.split(", ").each do |name|
    Given "#{model} \"#{name}\" is one of #{owner}'s #{assoc}"
  end
end

When /^I answer with "([^\"]*)"$/ do |answers|
  answers.split(', ').each do |answer|
    And "I fill in \"answer\" with \"#{answer}\""
    And "I press \"Check\""
  end
end

Then /^"([^\"]*)" should be marked$/ do |word|
  within "div#japanese" do |scope|
    scope.should have_selector('font') do |marking|
      marking.inner_html.should == word
    end
  end
end

Then /^I should see "([^\"]*)" as question$/ do |reading|
  Then %(I should see /^#{reading}$/ within "div#question")
end

Then /^I should see \/([^\/]*)\/ as correct answer$/ do |answer|
  Then %(I should see /^#{answer}$/ within "div#correct")
end

Then /^I should see "([^\"]*)" as correct answer$/ do |answer|
  Then %(I should see "#{answer}" within "div#correct")
end

Then /^I should see "([^\"]*)" as part answer$/ do |answer|
  Then %(I should see "#{answer}" within "div#part")
end
