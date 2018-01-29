require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sysrandom/securerandom'

configure(:development) do
  require 'sinatra/reloader'
end

require_relative 'lib/catalogue'

configure do
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
end

#### Routes ####

get '/' do
  haml :index
end

get '/load' do
  @data = Catalogue.new
  @data.load

  haml :data
end

post '/upload' do
  # Not yet supported.
end

#### Helpers ####

helpers do
  def current_flash_message
    session.delete(:flash) || ''
  end
end
