# repeat after me

share recorded voice for learning language  

![screenshot](https://raw2.github.com/kenzan8000/repeat-after.me/master/resources/screenshot/screenshot.jpg "screenshot")

1. record your voice
2. share the record
3. get the record review

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
      scope: 'public_profile,publish_actions,user_videos'
    }

production:
    ...
```

## mecab
```shell
# mac
brew install mecab mecab-ipadic
```
```shell
# cent os
curl https://mecab.googlecode.com/files/mecab-0.996.tar.gz
tar zxf mecab-0.996.tar.gz
cd mecab-0.996
./configure --with-charset=utf8 --enable-utf8-only
make
sudo make install
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
