Then(/^I should see "(.+)" table$/) do |category, table|
  html_table = table_at("#{category}").to_a
  html_table.map! { |r| r.map! { |c| c.gsub(/<.+?>/, '').gsub(/\r/,'').gsub(/\n/,'').gsub(/\t/,'') } }
  table.diff!(html_table)
end

Then(/^I should see #{capture_model} table$/) do |model, table|
  scope = get_scope( model )
  html_table = table_at("##{scope}").to_a
  html_table.map! { |r| r.map! { |c| c.gsub(/<.+?>/, '') } }
  table.diff!(html_table)
end