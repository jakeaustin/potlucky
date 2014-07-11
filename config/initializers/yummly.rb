Yummly.configure do |config|
  config.app_id = ENV['YUMMLY_ID']
  config.app_key = ENV['YUMMLY_TOKEN']
  config.use_ssl = true # Default is false
end
