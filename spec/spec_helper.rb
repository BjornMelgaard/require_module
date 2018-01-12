require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start

require_relative '../lib/require_module'

RSpec.configure do |config|
  config.color = true
end
