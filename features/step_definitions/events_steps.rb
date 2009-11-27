Then(/^I should see events table$/) do |table|
  table.diff!(table_at("#events").to_a)
end