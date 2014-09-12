require 'bundler'
Bundler.require
require_relative 'models/init'
# activerecord
require './models/tongue_twister.rb'
# the others
require './models/util.rb'


# constant
TTS_API = 'http://translate.google.com/translate_tts' # google tts api
#TTS_API = 'http://tts-api.com/tts.mp3' # tts api


configure :development do
  # log
  enable :sessions, :logging

#  # sass
#  Compass.configuration do |config|
#    config.project_path = File.dirname(__FILE__)
#    config.sass_dir = './assets/'
#  end
#  set :sass, Compass.sass_engine_options
end
# haml
set :haml, {:format => :html5}


# omniauth
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

get '/my_page' do
  if session[:uid]
    haml :my_page
  else
    redirect '/'
  end
end

get '/tongue_twisters*' do
  @tongue_twisters = TongueTwister.all
  haml :tongue_twisters
end

get '/record*' do
  if session[:uid]
    # paginator
    tongue_twister_id = params[:tongue_twister_id]

    # tongue_twister
    tongue_twister = TongueTwister.find(tongue_twister_id)
    @tongue_twister = tongue_twister.text.split(' ')
    # tts api
    @tts_uri = URI(TTS_API)
    @tts_uri.query = URI.encode_www_form({'ie' => 'UTF-8', 'tl' => 'en-us', 'q' => tongue_twister.text})
    #@tts_uri.query = URI.encode_www_form({'q' => tongue_twister.text, '&return_url' => '1'})

    # American IPA
    @ipa = AmericanIPA.text_to_ipa(tongue_twister.text)

    haml :record
  else
    redirect '/'
  end
end

get '/login' do
  if session[:uid]
    redirect '/auth/facebook'
  else
    haml :login
  end
end

get '/logout' do
  session.clear
  redirect '/'
end


# omniauth
get '/auth/:provider/callback' do
  info = request.env['omniauth.auth']
  session[:uid] = info['uid']
  session[:user_name] = info['info']['name']
  session[:image]= info['info']['image']
  redirect :tongue_twisters
end

get '/auth/failure' do
  redirect '/'
end


# assets
#configure :development do
#  get '/js/*.js' do
#    javascript :application
#  end
#
#  get '/css/*.css' do
#    sass :scss_file
#  end
#end
