Given(/^#{capture_model} has extra: #{capture_fields}$/) do |name, fields|
	hash = {}
	fields.split(', ').each do |field|
		(key, value) = field.split(': ')
		hash[key] = value
	end
	find_model( name ).first.update_attributes( hash )
end
