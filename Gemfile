source 'https://rubygems.org'

#gem 'bundler', '~> 1.3.0.pre.5'		        # Bundler version to match what is used on Heroku.

## Essentials
ruby '1.9.3'                              # Ruby!
gem 'rails', '3.2.13'                     # Rails!
gem 'pg'                                  # PostgreSQL, the database server
gem 'thin'                                # Web server
gem 'foreman'                             # For launching with the Procfile and keeping track of environment variables from .env

## Utilities
#gem 'pry-rails', :group => :development   # Better 'rails console'
#gem 'pry-exception_explorer', :group => :development # Puts you in the console when an exception is raised
#gem 'pry-debugger'                        # Adds next, step and continue to Pry for debugging

gem 'newrelic_rpm', :group => [:production, :staging, :development] # Rails analytics - see the Heroku addon
gem 'annotate', '~>2.4.1.beta'            # Annotates models with database info: `bundle exec rake:annotate`
gem 'rails-erd'                           # Create Entity Relationship Diagrams
gem 'progressbar'                         # Display progress bars in terminal output
gem 'facets', :require => false           # Some extra methods for ruby
gem 'seed_dump'                           # Adds a rake task which constructs a db/seeds.rb file based on the current database state.  Super useful!
gem 'jquery-ui-rails'                     # Package jQuery for the Rails 3.1+ asset pipeline
gem 'ruby-prof', '~> 0.13.0'             # ruby profiler

## SEO
gem 'meta-tags', :require => 'meta_tags'  # Search Engine Optimization (SEO) plugin for Ruby on Rails applications.

## Performance and optimization
gem 'delayed_job_active_record'           # Lets you queue tasks as background jobs
gem 'dalli'                               # memcache gem for Rails.cache
gem 'kgio'

## Admin
gem 'activeadmin', '0.4.4'                # Back-end Content Management System
gem 'devise', '~> 2.0'                    # User authentication
gem 'cancan'                              # User permissions

## Search and NLP
# gem 'indextank'
gem 'tanker'                              # library for interacting with Searchify
gem 'hunspell-ffi'                        # Spellchecking library
gem 'text'                                # NLP algorithms
gem 'httparty'                            # For accessing APIs directly
gem 'json'                                # Convert between JSON and Ruby objects
gem 'indextank'                           # library for interacting with Searchify

## Content and presentation
gem 'bluecloth'                           # Parse Markdown
gem 'kramdown'                            # Better markdown parser with support for markdown-extra
gem 'friendly_id'                         # Create permalinks / descriptive URLs / slugs
gem 'gon'                                 # Easy passing of data from the controller to javascript files
gem 'paperclip', '~> 3.0'                 # Easy file attachment library for ActiveRecord
gem 'aws-sdk', '~> 1.3.4'                 # Upload files to Amazon S3
#gem 'pagedown-rails', '1.0.0'             # Markdown editor

## Gems used only for assets and not required
## in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.5'            # Rails support for Sass, a CSS extension language
  gem "meta_search", '>= 1.1.0.pre'       # Active_admin search for form_for
  gem 'uglifier', '>= 1.0.3'              # Squash down Javascript for speed
  gem 'less-rails-bootstrap'              # Improves the Rails / Twitter Boostrap relationship by adding support for LESS, a CSS extension language
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'                      # Embeds the V8 Javascript interpreter into Ruby
end

# TODO: organize test, dev gems better
group :test, :development do
  gem 'rspec-rails', '>= 2.10.1'
  gem 'shoulda'
  gem 'capybara'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'capybara-webkit'
  gem 'memcached'
  gem 'sextant'
  gem 'dotenv-rails'
  gem 'webmock'
end

gem 'test-unit'                           # Remove at your peril.  Too many other gems randomly depend on it.

group :test do
  gem 'database_cleaner'
  gem 'simplecov', :require => false
end
