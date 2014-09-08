# repeat after me

share tongue-twister you pronounced.

## hosts
```shell
vim etc/hosts
```
```
127.0.0.1           local.repeat.after.me
```

## omniauth
```shell
vim app/config/auth.yml
```
```yml
development:
  omniauth:
    enabled: true
    allow_single_sign_on: true or false
    block_auto_created_users: true or false
  providers:
    {
      name: 'hoge',
      app_id: 'YOUR_APP_ID',
      app_secret: 'YOUR_APP_SECRET',
      scope: 'hoge,fuga'
    }

production:
    ...
```

## database
### setting
```shell
vim app/config/database.yml
```
```yml
development:
  adapter: sqlite3
  encoding: utf8
  database: db/development.db
  username: hoge
  password: fuga

production:
  adapter: postgresql
  host: localhost
  username: hoge
  password: fuga
  database: app
```
### migration
```shell
cd app
rake migrate
```

## run app
```shell
cd app
bundle install
rake build server
```
