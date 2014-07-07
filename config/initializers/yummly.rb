Yummly.configure do |config|
  config.app_id = "f1f51664"
  config.app_key = ENV['YUMMLY_TOKEN']
  config.use_ssl = true # Default is false
end
