require 'bundler'
Bundler.require
require_relative 'models/init'
# activerecord
require './models/record_title.rb'
require './models/record.rb'
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
  @record_categories_jp = RecordTitle.pluck(:category_jp).uniq
  @record_categories_en = RecordTitle.pluck(:category_en).uniq
  @record_counts = Array.new
  @record_categories_jp.each do |record_category_jp|
    @record_counts.push(RecordTitle.count(:category_jp => record_category_jp))
  end

  haml :record_titles
end

get '/record/titles/:category_en' do
  category_en = params[:category_en]
  if category_en == nil
    redirect '/record/titles'
    return
  end

  @record_titles = RecordTitle.where(:category_en => category_en)
  if @record_titles == nil
    redirect '/record/titles'
    return
  end

  @record_category_jp = @record_titles.first.category_jp

  haml :record_titles_category
end

get '/record/post/:record_title_id' do
  record_title_id = params[:record_title_id]

  if session[:uid] == nil
    redirect '/'
    return
  elsif record_title_id
    @record_title = RecordTitle.find(record_title_id)
    if @record_title == nil
      redirect '/'
      return
    end

    # record_title_en
    @record_title_en = @record_title.text_en.split(' ')
    # tts api
    @tts_uri = URI(TTS_API)
    @tts_uri.query = URI.encode_www_form({'ie' => 'UTF-8', 'tl' => 'en-us', 'q' => @record_title.text_en})
    # American IPA
    @ipa = AmericanIPA.text_to_ipa(@record_title.text_en)

    haml :record_post
  else
    redirect '/'
  end
end

post "/record/post/:record_title_id" do
  response = {}

  # 401
  if session[:uid] == nil
    response['application_code'] = '401'
    return response.to_json
  end

  response['application_code'] = '500'

  # lacking record_title_id
  if params[:record_title_id] == nil
    return response.to_json
  end

  # convert mp3 to mp4
  mp4_path = MP4Converter.mp4_path(params)
  if mp4_path == nil
    return response.to_json
  end

  # publish to facebook timeline
  title = "REPEAT AFTER ME"
  message = "#{request.url}"
  publish_response = VideoUploader.post(session[:token], mp4_path, title, message)
  if publish_response['id'] == nil
    return response.to_json
  end

  # register record table
  user = User.find_by(facebook_user_id:session[:uid])
  if user == nil
    return response.to_json
  end
  record = Record.new
  record.user_id = user.id
  record.record_title_id = params[:record_title_id]
  record.facebook_post_id = publish_response['id']
  record.save

  response['application_code'] = '200'
  response['redirect_url'] = "/record/detail/#{record.id}"

  response.to_json
end

get "/record/detail/:id" do
  record_id = params[:id]
  record = Record.find(record_id)
  #record.facebook_post_id

  # user
  @post_user = User.find(record.user_id)
  if @post_user == nil
    redirect '/'
    return
  end
  # record_title
  @record_title = RecordTitle.find(record.record_title_id)
  if @record_title == nil
    redirect '/'
    return
  end
  # record_title_en
  @record_title_en = @record_title.text_en.split(' ')
  # American IPA
  @ipa = AmericanIPA.text_to_ipa(@record_title.text_en)
  # post_date
  @post_date = record.updated_at.strftime("%Y %1m/%1d %1H:%1M")

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
  session[:image] = info['info']['image']
  session[:token] = info['credentials']['token']

  # register user table
  user = User.where(facebook_user_id:session[:uid]).first
  user = User.new if user == nil
  user.facebook_user_id = session[:uid]
  user.name = session[:user_name]
  user.profile_image_url = session[:image]
  user.login_count = (user.login_count) ? user.login_count+1 : 0
  user.save

  redirect '/record/titles'
end

get '/auth/failure' do
  redirect '/'
end
