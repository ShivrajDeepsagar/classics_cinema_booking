# Classic Movie Booking

* Ruby version: ruby 2.4.1

### First-Time Setup:

1. Copy and modify the database.yml file: `cp config/database.yml.example config/database.yml`
2. Run `bundle install` to install all the gems
3. Run `rake db:create` create the database
4. Run `rake db:seed` seed the data
5. Now access the app at 'http://localhost:3000'.

### Handling updates:

1. Run `bundle install`
2. Run `rails db:migrate`
