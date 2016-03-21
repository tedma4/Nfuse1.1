# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( jquery.easing.min.js )
Rails.application.config.assets.precompile += %w( jquery.slimscroll.min.js )
Rails.application.config.assets.precompile += %w( jasny-bootstrap.min.js )
Rails.application.config.assets.precompile += %w( nfuse.js )
Rails.application.config.assets.precompile += %w( resize_masonry.js )
Rails.application.config.assets.precompile += %w( imagesloaded.pkgd.js )
Rails.application.config.assets.precompile += %w( masonry.pkgd.js )
Rails.application.config.assets.precompile += %w( jquery.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
