ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
#Commented out to avoid attempting to reset the database when tests are run
#require "rails/test_help"
ActiveRecord::Base.maintain_test_schema = false


class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)
end
