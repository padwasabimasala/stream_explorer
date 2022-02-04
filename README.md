# README

ActiveAdmin app for exploring Eventide MessageDB messages

# Quick Start

```
  docker-compose up
  rails db:migrate
  rails server
```

The before you start you have to add an admin user the database via rails console
```
  > AdminUser.create email: "admin@example.com", password: "password"
```


