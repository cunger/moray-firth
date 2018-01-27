require 'dotenv'
Dotenv.load

require 'sinatra'
require 'sysrandom/securerandom'

configure(:development) do
  require 'sinatra/reloader'
end

configure do
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
end

#### Routes ####

get '/' do
  haml :index
end

post '/upload' do
  # `mdb-export #{params[:file][:tempfile]} Stiffs`

  haml :data
end

#### Helpers ####

helpers do
  def current_flash_message
    session.delete(:flash) || ''
  end
end
