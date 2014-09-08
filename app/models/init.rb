# ActiveRecord
configure :development do
  db_config = YAML.load_file('config/database.yml')
  ActiveRecord::Base.establish_connection(db_config['development'])
end
configure :production do
  db_config = YAML.load_file('config/database.yml')
  ActiveRecord::Base.establish_connection(db_config['production'])
end


class User < ActiveRecord::Base
#  has_many :
end
