# Load the rails application
require File.expand_path('../application', __FILE__)

SUBSCRIBE = {}
SUBSCRIBE['SQL'] = true

# Initialize the rails application
Bachelor::Application.initialize!
