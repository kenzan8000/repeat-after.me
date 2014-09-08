# repeat after me

share tongue-twister you pronounced.

### hosts setting
```shell
vim etc/hosts
```
```
127.0.0.1           local.repeat.after.me
```

### omniauth setting
```shell
vim app/config/auth.yml
```
```
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

### migration
```shell
cd app
rake migrate
```

### run app
```shell
cd app
bundle install
rake build server
```
