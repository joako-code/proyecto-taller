require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.environment == :development

# Define una clase 'App' que hereda de 'Sinatra::Application',
# convirtiéndola en una aplicación web Sinatra.
class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end


  # Define una ruta para solicitudes GET a la URL raíz ('/').
  get '/' do
    'Welcome to Clover!'
  end

  get '/queonda' do
    'Que onda!'
  end

  get '/jefe' do
    'Sos el mejorr!'
  end
end
