# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
# ActionMailer::Base.smtp_settings = {
#     :user_name => 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
#     :password => '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', # This is the secret sendgrid API key which was issued during API key creation
#     :domain => 'heroku.com',
#     :address => 'smtp.sendgrid.net',
#     :port => 587,
#     :authentication => :plain,
#     :enable_starttls_auto => true
#   }
  