# Simple Notes API

This is API for simple notes app.

## System version

* **> ruby 2.5.1**
* **> Rails 5.2.3**

## System dependencies

* PostgreSQL
* rspec-rails
* factory_bot_rails
* shoulda_matchers
* database_cleaner
* faker

## Configuration

database

* Create file /config/database.yml
* Copy all variable from /config/database.yml.example into /config/database.yml
* Change value of /config/database.yml based on your working environment

secrets
* Create file /config/secrets.yml
* Copy all variable from /config/secrets.yml.example into /config/secrets.yml
* Change value of /config/secrets.yml based on your working environment

## Database creation and initialization

Please run this code in sequence

```
rails db:create
rails db:migrate
```

## Testing

execute code below to run the unit testing.

```
bundle exec rspec
```

Here is the example of the result of the unit testing.

```
..............................................

Finished in 1.3 seconds (files took 2.51 seconds to load)
46 examples, 0 failures
```