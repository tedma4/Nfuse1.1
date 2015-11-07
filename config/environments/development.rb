Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.cache_store = :memory_store, { size: 64.megabytes }
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # config.action_controller.asset_host = 'http://localhost:3000'

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  Paperclip.options[:command_path] = "C:/Program Files/ImageMagick-6.9.1-Q16/convert.exe"
  Paperclip.options[:command_path] = "C:/Program Files/ImageMagick-6.9.1-Q16/ffmpeg.exe"
  # Paperclip.options[:command_path] = "C:/ffmpeg/bin/ffmpeg.exe"
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :domain          => "gmail.com",
      :address         => 'smtp.gmail.com',
      :port            =>  587,
      :authentication  => :plain,
      :user_name       => ENV['gmail_email'],
      :password        => ENV['gmail_password']

  }

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    # Bullet.rails_logger = true
    # Bullet.honeybadger = true
    # Bullet.bugsnag = true
    # Bullet.airbrake = true
    # Bullet.rollbar = true
    Bullet.add_footer = true
    #Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    #Bullet.slack = { webhook_url: 'http://some.slack.url', foo: 'bar' }
  end

end
