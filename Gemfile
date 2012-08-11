source 'http://rubygems.org'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

#############################

gem "rails", "3.0.11"
gem "mongo", "1.6.2"
gem "mongoid", "2.2.6"
gem "bson_ext", "1.4"
gem "devise", "1.5.1"
gem "brazilian-rails", "3.0.4"
gem "cancan", "1.6.7"
gem "paperclip", "2.4.5"
gem "mongoid-paperclip", "0.0.7" #gem que integra o paper-clipe com o mongoid para upload de arquivos
gem "simple_form", "1.5.2"
gem "jquery-rails", "1.0.18"
gem "mongoid_rails_migrations", "0.0.14" #permite criar e executar migrations com Mongoid
#gem "aws-s3" >> Gem do Amazon Sevice para hospedagem de arquivo no amazon (por enquanto nao utilizada))
gem "kaminari", "0.13.0" #Gem para paginação

group :development, :test do
#  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'cucumber-rails'
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions
  gem 'database_cleaner' # to clear Cucumber's test database between runs
  gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
  gem 'factory_girl_rails'
#  gem 'rspec-rails'
#  gem 'simplecov'
end

#rails generate cucumber:install capybara
#rails generate cucumber_rails_training_wheels:install
#rails generate rspec:install