require 'bundler'
Bundler.require
require_relative 'models/init'
# activerecord
require './models/record_title.rb'
require './models/user.rb'
# the others
require './models/util.rb'


# constant
TTS_API = 'http://translate.google.com/translate_tts' # google tts api


configure :development do
  enable :sessions, :logging
end
configure :production do
  enable :sessions
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


get '/' do
  haml :index
end

get '/record/titles' do
  @record_titles = RecordTitle.all
  haml :record_titles
end

get '/record/post' do
  # paginator
  record_title_id = params[:record_title_id]

  if session[:uid] && record_title_id
    record_title = RecordTitle.find(record_title_id)
    # record_title
    @record_title = record_title.text.split(' ')
    # tts api
    @tts_uri = URI(TTS_API)
    @tts_uri.query = URI.encode_www_form({'ie' => 'UTF-8', 'tl' => 'en-us', 'q' => record_title.text})
    # American IPA
    @ipa = AmericanIPA.text_to_ipa(record_title.text)

    haml :record_post
  else
    redirect '/'
  end
end

post "/record/post" do
  response = {}
  # 401
  if session[:uid] == nil
    response['application_code'] = '401'
    return response.to_json
  end

  # convert mp3 to mp4
  mp4_path = MP4Converter.mp4_path(params)
  if mp4_path
    response['application_code'] = '200'
    response['redirect_url'] = '/record/detail'
  else
    response['application_code'] = '500'
    return response.to_json
  end

  response.to_json
end

get "/record/detail" do
  haml :record_detail
end

get '/user' do
  haml :user
end

get '/tutorial' do
  haml :tutorial
end

get '/login' do
  redirect '/auth/facebook'
end

get '/logout' do
  session.clear
  redirect '/'
end


# omniauth
get '/auth/:provider/callback' do
  # get session
  info = request.env['omniauth.auth']
  session[:uid] = info['uid']
  session[:user_name] = info['info']['name']
  session[:image]= info['info']['image']

  # register user table
  user = User.where(user_id: session[:uid]).first
  user = User.new if user == nil
  user.user_id = session[:uid]
  user.name = session[:user_name]
  user.profile_image_url = session[:image]
  user.save

  redirect '/record/titles'
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
