Webrat.configure do |config|
  config.mode = :rails
  # Selenium defaults to using the selenium environment. Use the following to override this.
  # config.application_environment = :test
end

# truncate your tables here if you are using the same database as selenium, since selenium doesn't use transactional fixtures
Cucumber::Rails.use_transactional_fixtures
