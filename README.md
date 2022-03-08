# README

ActiveAdmin app for exploring Eventide MessageDB messages

# Quick Start

```
  docker-compose up
  rails db:migrate
  rails server
```
You can explore your messages at admin at http://localhost:3000/admin/messages

# Authenticaion

Authentication is disabled by default. See details in [the guide](https://activeadmin.info/1-general-configuration.html)
to enable authenticaion. If use enable admin user authentication you can create a user with `rails runner 'AdminUser.create email: "admin@example.com", password: "password"'`


# Message Store Connection

You can override the postgres database connection using standard PG envars like so

```
export PGHOST=
export PGUSER=
export PGDATABASE=
export PGPASSWORD=
```
