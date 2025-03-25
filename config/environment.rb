# Load the Rails application.
require_relative "application"

Rails.application.config.active_support.to_time_preserves_timezone = :zone

# Initialize the Rails application.
Rails.application.initialize!
