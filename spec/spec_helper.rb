require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start

require_relative '../lib/include_relative'

RSpec.configure do |config|
  config.color = true
end
