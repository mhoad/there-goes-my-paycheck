Paycheck::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  #config.assets.compile = true
  #config.assets.compress = true
  config.assets.debug = true

  #Settings for AWS / Cloudfront
  config.assets.enabled = true
  config.action_controller.asset_host = "http://geekgifts-dev.s3.amazonaws.com/"
  config.assets.initialize_on_precompile = true


  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  config.paperclip_defaults = {
    :url => ':s3_domain_url',
    :path => "images/:category_name/:style/:basename.:extension",
    :storage => :s3,
    :bucket => ENV['S3_BUCKET_NAME_DEV'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
end
