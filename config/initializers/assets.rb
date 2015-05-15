# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( masonry.pkgd.js )
Rails.application.config.assets.precompile += %w( imagesloaded.pkgd.js )
# Rails.application.config.assets.precompile += %w( edge_includes/edge.5.0.1.min.js )
# Rails.application.config.assets.precompile += %w( edge_includes/SuperStretchConcept_edge.js )
Rails.application.config.assets.precompile += %w( resize_masonry.js )
Rails.application.config.assets.precompile += %w( vjs.eot )
Rails.application.config.assets.precompile += %w( vjs.woff )
Rails.application.config.assets.precompile += %w( vjs.ttf )
Rails.application.config.assets.precompile += %w( video-js.swf )
Rails.application.config.assets.precompile += %w( jquery-1.11.1.min.js )
# Rails.application.config.assets.precompile += %w( bootstrap.min.js )
# Rails.application.config.assets.precompile += %w( jquery.backstretch.min.js )
Rails.application.config.assets.precompile += %w( wow.min.js )
# Rails.application.config.assets.precompile += %w( retina-1.1.0.min.js )
Rails.application.config.assets.precompile += %w( jquery.magnific-popup.min.js )
Rails.application.config.assets.precompile += %w( scripts.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
