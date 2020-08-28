# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts', 'futura')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( active_admin/active_admin_globalize.css )
Rails.application.config.assets.precompile += %w( active_admin/active_admin_globalize.js )
Rails.application.config.assets.precompile += %w( *.svg *.eot *.woff *.woff2 *.ttf *.png base.js base.css) 


# new application
Rails.application.config.assets.precompile += %w( new_application.css new_application.js )
