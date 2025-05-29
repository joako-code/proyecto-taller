require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require 'logger'
require 'sinatra/activerecord'
require_relative 'models/user'


class App < Sinatra::Application

  set :views, File.expand_path('../views', __FILE__) #indico explicitamente a sintara donde estan las vistas

  configure :development do
    enable :logging
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger

    register Sinatra::Reloader
    after_reload do
      logger.info 'Reloaded!!!'
    end
  end

  get '/' do
    settings.logger.info "Serving the root path"
    'Welcome todo bien?'
  end

  # Rutas para vistas
  get '/signup' do
    erb :signup
  end

  get '/login' do
    erb :login
  end

  get '/welcome' do
    # Simulación de usuario logueado para mostrar la vista
    @user = User.first
    erb :welcome
  end
end
