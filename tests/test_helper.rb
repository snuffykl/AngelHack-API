if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.minimum_coverage(ENV['UNITTEST_MINIMUM_COVERAGE'] || 90)
  SimpleCov.start do
    add_filter 'tests/'
    add_filter 'vendor/'
    command_name 'Mintest'
  end
end
