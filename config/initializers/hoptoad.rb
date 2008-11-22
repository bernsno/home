# Then rake hoptoad:test to make sure it works!
HoptoadNotifier.configure do |config|
  config.api_key = ''
end

# Thanks Blank (http://github.com/giraffesoft/blank/tree/)
RAILS_DEFAULT_LOGGER.warn('Please add a hoptoad key to config/initializers/hoptoad.rb.') if HoptoadNotifier.api_key.blank?