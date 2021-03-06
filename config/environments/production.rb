Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  # config.use_ssl = false
  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true
  # config.action_controller.asset_host = 'http://nfuse.it'
  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true
  config.assets.precompile +=  %w(*.js, *.css, *.js.erb *.css.erb )
  # config.assets.precompile << /\A(?!(active_admin)).*\.(js|css)\z/
  # config.assets.precompile << /\A(?!(active_admin)|(bourbon)).*\.(js|css)\z/
  # Generate digests for assets URLs.
  config.assets.digest = true

  # `config.assets.precompile` has moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.use_ssl = false

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  config.cache_store = :memory_store, { size: 64.megabytes }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false
    #Used for video.js
# config.assets.precompile += %w( video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff )
  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.default_url_options = { :host => "nfuse.it" }

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
  config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif] 
  
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
 
  # Sets Paperclip to upload images to Amazon S3
  config.paperclip_defaults = {
    storage: :s3,
    s3_host_name: 's3-us-west-1.amazonaws.com',
    s3_credentials: {
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_KEY"]
    },
    bucket: ENV["AWS_BUCKET_NAME"],
    path: "/:class/:attachment/:id/:style/:filename"
  }

end
