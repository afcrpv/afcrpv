source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.2.1.1'
  gem 'compass-rails'
  gem "jquery-ui-rails"
  gem "select2-rails"
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# Refinery CMS
gem 'refinerycms', '~> 2.0.9'

# Specify additional Refinery CMS Extensions here (all optional):
#  gem 'refinerycms-blog', '~> 2.0.0'
#  gem 'refinerycms-page-images', '~> 2.0.0'
gem 'refinerycms-i18n', '~> 2.0.0'
gem 'refinerycms-search', '~> 2.0.0', github: 'refinery/refinerycms-search', branch: '2-0-stable'
gem 'refinerycms-inquiries', '~> 2.0.0', github: 'refinery/refinerycms-inquiries', branch: '2-0-stable'
gem 'refinerycms-memberships', git: "git://github.com/adamico/refinerycms_membership.git"
gem 'refinerycms-settings', git: "git://github.com/refinery/refinerycms-settings.git", branch: "2-0-stable"
gem 'refinerycms-crpvs', :path => 'vendor/extensions'
gem 'refinerycms-projets', :path => 'vendor/extensions'
gem 'refinerycms-documents', :path => 'vendor/extensions'
gem 'refinerycms-news_categories', :path => 'vendor/extensions'
gem "refinerycms-news", '~> 2.0.0', github: 'refinery/refinerycms-news', branch: '2-0-stable'

# Fog allows you to use S3 assets (added for Heroku)
gem 'fog'
gem 'newrelic_rpm', "~> 3.5.3.25"

gem 'thin'
gem 'dalli'
gem 'humanizer'
gem 'simple_form'
gem 'show_for', github: "plataformatec/show_for"
gem 'humanizer'
gem "the_sortable_tree", "~> 2.3.0"
gem "acts-as-taggable-on", "~> 2.3.1"
gem 'jquery-datatables-rails'
gem "squeel"
gem "workflow"

group :development do
  gem 'meta_request'
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry-rails"
  gem "quiet_assets", ">= 1.0.1"
end
