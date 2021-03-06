# README

ActiveAdmin app for exploring Eventide MessageDB messages

# Quick Start

Configure your message store connection in the environment and run `make`.

```
export PGHOST=
export PGUSER=
export PGDATABASE=
export PGPASSWORD=

make
```

You can explore your messages at admin at http://localhost:3000/

# Docker Compose and local development

A docker-compose.yml file is included to support local development, if you wish to run a local instance of the message store and also Postgres instance (for authenticaion).

```
  docker-compose up
  rails db:migrate
  rails server
```

The message store runs on the default Postgres pots 5432. The Postgres db is the primary Rails db and exists to allow for ActiveAdmin comments and authenticaion. This database is not needed in order to explore the message store but might be necessary to support authentication in a deployed or production environment.

Message store and database configuration information can be found in config/database.yml

## Configuration

### PORT

By default the app listens on port 3000. This can be overwritten by exporting a PORT variable.

```
  # listen port 8080
  export PORT=8080
  make
```

# Authentication

Authentication is disabled by default. See details in [the guide](https://activeadmin.info/1-general-configuration.html)
to enable authenticaion. If use enable admin user authentication you can create a user with `rails runner 'AdminUser.create email: "admin@example.com", password: "password"'`

# Testing

```
  docker-compose up
  bin/rails db:environment:set RAILS_ENV=test
  bin/rails test
```

