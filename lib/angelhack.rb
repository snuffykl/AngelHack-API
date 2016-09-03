$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

# Make sure logging info flushed to stdout immediately
STDOUT.sync = true

# API endpoints
module API
	require 'grape'
	require 'json'
	require 'pry-byebug'
	require 'net/http'

	autoload :Endpoints, 'api/endpoints'
	autoload :Category, 'api/category'
end

