# ActiveRecord
configure :development do
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'app.sqlite3'
  )
end
configure :production do
  ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'app'
  )
end


class User < ActiveRecord::Base
#  has_many :
end
