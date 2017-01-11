# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Amazon::Ecs.options = {
  associate_tag: ENV['ASSOCIATE_TAG'],
  AWS_access_key_id: ENV['AWS_ACCESS_KEY'],
  AWS_secret_key: ENV['AWS_SECRET_KEY']
}
