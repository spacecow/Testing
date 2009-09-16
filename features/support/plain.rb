Webrat.configure do |config|
  config.mode = :rails
  # Selenium defaults to using the selenium environment. Use the following to override this.
  # config.application_environment = :test
end

# truncate your tables here if you are using the same database as selenium, since selenium doesn't use transactional fixtures
Cucumber::Rails.use_transactional_fixtures
TemplateClass.delete_all
Course.delete_all
Klass.delete_all
Student.delete_all
Teacher.delete_all
Person.delete_all
Attendance.delete_all
Teaching.delete_all

#count = 0
#After do |scenario|
#  if scenario.failed?
#    p (count+=1).to_s+": #{scenario.exception.message}"
#  end
#end
