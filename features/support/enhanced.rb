#require 'webrat'
require 'spec/expectations'
require 'selenium'

#Webrat.configure do |config|
 # config.mode = :selenium
  # Selenium defaults to using the selenium environment. Use the following to override this.
  # config.application_environment = :test
#end

app_server_host = "localhost"
app_port = "3001"
selenium_server_host = "localhost"
browser_name = "*chrome C:/Program Files/Mozilla Firefox/firefox.exe"
#"C:\Program Files\Google\Chrome\Application\chrome.exe"
#"*chrome C:/Program Files/Mozilla Firefox/firefox.exe"
#"*iexplore C:/Program Files/Internet Explorer/iexplore.exe"
Webrat.configure do |config| 
  config.mode = :selenium 
#  config.application_environment = :test 

# Tell where the application is running on for selenium to test 
#  config.application_address = "#{app_server_host}" 
#  config.application_port = "#{app_port}" 

# Tell where selenium server is running on, when not specified defaults 
# to nil (server starts in webrat process and runs locally) 
  config.selenium_server_address = "#{selenium_server_host}" 
  config.selenium_server_port = "4444" 

# Set the key that Selenium uses to determine the browser running 
#  config.selenium_browser_key = '#{browser_name}' 

end 

# this is necessary to have webrat "wait_for" the response body to be available
# when writing steps that match against the response body returned by selenium
World(Webrat::Selenium::Matchers)

# "before all"

browser = Selenium::SeleniumDriver.new("localhost", 4444, browser_name, "http://localhost:3001", 15000)

Before do
  @browser = browser
  @browser.start	
  	
	TemplateClass.delete_all
	Course.delete_all
	Klass.delete_all
	Student.delete_all
	Teacher.delete_all
	Person.delete_all
	Attendance.delete_all
	Teaching.delete_all
	ScheduledUnit.delete_all
	Schedule.delete_all
	Unit.delete_all
end

After do
  @browser.stop
end

# "after all"
at_exit do
  @browser.close rescue nil
end
