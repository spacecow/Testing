Then(/^I should see "(.+)" table$/) do |category, table|
  table.diff!(table_at("##{category}").to_a)
end

Then(/^I should see #{capture_model} table$/) do |model, table|
  scope = get_scope( model )
  table.diff!(table_at("##{scope}").to_a)
end