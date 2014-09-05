# OmniAuth
#use OmniAuth::Builder do
#  auth_config = YAML.load_file('config/auth.yml')
#  provider :google, auth_config["providers"]["app_id"], auth_config["providers"]["app_secret"]
#end


# ActiveRecord
#db_config = YAML.load_file('config/database.yml')
#configure :development do
#  ActiveRecord::Base.establish_connection(db_config["development"])
#end
#configure :production do
#  ActiveRecord::Base.establish_connection(db_config["production"])
#end

#class User < ActiveRecord::Base
##  has_many :
#end


# Check Auth
#before do
#  if request.cookies['rack.session']
#    session_id = Digest::SHA1.hexdigest( request.cookies['rack.session'] )
#    if @session = Session.find_by_session_id(session_id)
#      @login_user = @session.data[:user]
#    end
#  end
#end
