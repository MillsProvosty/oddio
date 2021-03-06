# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

SimpleCov.start

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<GOOGLE_PLACES_API_KEY>') { ENV['GOOGLE_PLACES_API_KEY'] }
  config.filter_sensitive_data('<TOMTOM_API_KEY>') { ENV['TOMTOM_API_KEY'] }
  config.filter_sensitive_data('<AWS_ACCESS_KEY>') { ENV['AWS_ACCESS_KEY'] }
  config.filter_sensitive_data('<AWS_SECRET_ACCESS_KEY>') { ENV['AWS_SECRET_ACCESS_KEY'] }
  config.filter_sensitive_data('<AWS_BUCKET>') { ENV['AWS_BUCKET'] }
  config.filter_sensitive_data('<AWS_REGION>') { ENV['AWS_REGION'] }
  config.filter_sensitive_data('<GOOGLE_CLIENT_ID>') { ENV['GOOGLE_CLIENT_ID'] }
  config.filter_sensitive_data('<GOOGLE_CLIENT_SECRET>') { ENV['GOOGLE_CLIENT_SECRET'] }
  config.filter_sensitive_data('<GOOGLE_INDIV_UID>') { ENV['GOOGLE_INDIV_UID'] }
  config.filter_sensitive_data('<GOOGLE_INDIV_TOKEN>') { ENV['GOOGLE_INDIV_TOKEN'] }
  config.filter_sensitive_data('<MAPBOX_API_KEY>') { ENV['MAPBOX_API_KEY'] }
  config.filter_sensitive_data('<VOTES_API_KEY>') { ENV['VOTES_API_KEY'] }
  config.default_cassette_options = { record: :new_episodes }
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|

  config.include FactoryBot::Syntax::Methods

  config.after(:each) { FactoryBot.reload }

  config.after(:each) { Faker::UniqueGenerator.clear }

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def mock_oauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
    'provider' => 'google_oauth2',
    'uid' => ENV['GOOGLE_INDIV_UID'],
    'info' => {
      'email' => 'alexchakeres@gmail.com',
      'first_name' => 'Alexandra',
      'last_name' => 'Chakeres'
    },
    'credentials' => {
      'token' => ENV['GOOGLE_INDIV_TOKEN']
    }
  )
end
