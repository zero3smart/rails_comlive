source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '>= 5.0.0.beta4', '< 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'unitwise'
gem 'figaro'
gem 'roo', '~> 2.0.0'
gem 'font-awesome-rails'
gem 'will_paginate-bootstrap'
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'will_paginate', '~> 3.1.0'
gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'searchkick'

group :development, :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'factory_girl_rails', "~> 4.4.1"
  gem 'rails-controller-testing'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'guard-rspec', require: false
end

group :test do
  gem "faker", git: "https://github.com/stympy/faker"
  gem "capybara", git: "https://github.com/jnicklas/capybara"
  gem "database_cleaner", "~> 1.3.0"
  gem "launchy", "~> 2.4.2"
  gem 'poltergeist'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Auth0 integration
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-auth0', '~> 1.4.1'
gem 'knock', '~> 1.4.2'

# API
gem 'active_model_serializers'
gem 'versionist'