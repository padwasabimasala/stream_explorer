# README

ActiveAdmin app for exploring Eventide MessageDB messages

# Quick Start

Run `make`

You can explore your messages at admin at http://localhost:3000/

# Authenticaion

Authentication is disabled by default. See details in [the guide](https://activeadmin.info/1-general-configuration.html)
to enable authenticaion. If use enable admin user authentication you can create a user with `rails runner 'AdminUser.create email: "admin@example.com", password: "password"'`

# Message Store Connection

You can override the message store connection using standard PG envars like by exporting them in your environment and passing them into the docker container.

```
export PGHOST=
export PGUSER=
export PGDATABASE=
export PGPASSWORD=

docker run -p 3000:3000 --env PGPASSWORD --env PGHOST --env PGUSER --env PGDATABASE streamy
```

# Docker Compose and local development

A docker-compose.yml file is included to support local development, if you wish to run a local instance of the message store and also Postgres instance (for authenticaion).

```
  docker-compose up
  rails db:migrate
  rails server
```

The message store runs on the default Postgres pots 5432. The Postgres db is the primary Rails db and exists to allow for ActiveAdmin comments and authenticaion. This database is not needed in order to explore the message store but might be necessary to support authentication in a deployed or production environment.

Message store and database configuration information can be found in config/database.yml
