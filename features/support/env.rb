ENV["RAILS_ENV"] = "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode'
require 'webrat/rails'
require 'cucumber/rails/rspec'
require "#{Rails.root}/test/factories"

# Comment out the next line if you want Rails' own error handling
# (e.g. rescue_action_in_public / rescue_responses / rescue_from)
Cucumber::Rails.bypass_rescue

#require 'cucumber/rails/rspec'
#require 'webrat/core/matchers'