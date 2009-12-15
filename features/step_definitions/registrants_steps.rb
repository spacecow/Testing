Then(/^I should see registrants table$/) do |table|
  table.diff!(table_at("#registrants").to_a)
end