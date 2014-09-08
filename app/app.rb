require 'bundler'
Bundler.require


set :haml, {:format => :html5}
enable :sessions, :logging


require_relative 'models/init'
require './models/tongue_twister.rb' if development?


# constant
TTS_API = 'http://translate.google.com/translate_tts'

# OmniAuth
use OmniAuth::Builder do
  auth_config = YAML.load_file('config/auth.yml')
  auth_config = auth_config['development'] if development?
  auth_config = auth_config['production'] if production?

  provider :facebook, auth_config['providers']['app_id'], auth_config['providers']['app_secret'], :scope => auth_config['providers']['scope']
end

#before do
#  if request.cookies['rack.session']
#    session_id = Digest::SHA1.hexdigest( request.cookies['rack.session'] )
#    if @session = Session.find_by_session_id(session_id)
#      @login_user = @session.data[:user]
#    end
#  end
#end


get '/' do
  haml :index
end

get '/tongue_twisters*' do
  @tongue_twisters = TongueTwister.all
  haml :tongue_twisters
end

get '/record*' do
  tongue_twister_id = params[:tongue_twister_id]

  # tongue_twister
  @tongue_twister = TongueTwister.find(tongue_twister_id)
  # google tts api
  @tts_uri = URI(TTS_API)
  @tts_uri.query = URI.encode_www_form({'ie' => 'UTF-8', 'tl' => 'en-us', 'q' => @tongue_twister.text})

  haml :record
end

get '/login' do
  if session[:uid] == nil
    haml :login
  else
    redirect '/auth/facebook'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/auth/:provider/callback' do
  info = request.env['omniauth.auth']
  session[:uid] = info['uid']
  session[:user_name] = info['info']['name']
  session[:image]= info['info']['image']
  redirect '/'
end

get '/auth/failure' do
  redirect '/'
end

#get '/js/*.js' do
#  javascript :application
#end
#
#get '/css/*.css' do
#  sass :application
#end
#
#get '/auth/google/callback' do
#  @auth = request.env['omniauth.auth']
#  #params[:oauth_token]
#  #params[:oauth_verifier]
#  haml :index
#end
