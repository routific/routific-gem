require 'bundler/setup'
Bundler.setup

require 'pry'
require 'pry-debugger'
require 'faker'

require 'dotenv'
Dotenv.load

require 'routific'

require_relative './factory'

RSpec.configure do |config|
end