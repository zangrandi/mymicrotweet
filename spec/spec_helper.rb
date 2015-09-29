require 'factory_girl_rails'
require 'capybara/rspec'
require 'devise'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  
	config.include FactoryGirl::Syntax::Methods
	config.include Devise::TestHelpers, :type => :controller

	config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
end