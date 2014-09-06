require 'bundler'
Bundler.require


set :haml, {:format => :html5}
enable :sessions, :logging


#require_relative 'models/init'


get '/' do
  haml :index
end

get '/record*' do
  haml :record
end

#get "/js/*.js" do
#  javascript :application
#end
#
#get "/css/*.css" do
#  css :application
#end
#
#get '/auth/google/callback' do
#  @auth = request.env['omniauth.auth']
#  #params[:oauth_token]
#  #params[:oauth_verifier]
#  haml :index
#end
