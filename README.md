# README

ActiveAdmin app for exploring Eventide MessageDB messages

# Quick Start

```
  docker-compose up
  rails db:migrate
  'rails runner 'AdminUser.create email: "admin@example.com", password: "password"''
  rails server
```
You can explore your messages at admin at http://localhost:3000/admin/messages

You can override the postgres database connection using standard PG envars like so

```
export PGHOST=
export PGUSER=
export PGDATABASE=
export PGPASSWORD=
```
