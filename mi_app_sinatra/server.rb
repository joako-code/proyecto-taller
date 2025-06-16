require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader' if Sinatra::Base.environment == :development
require 'logger'
require 'sinatra/activerecord'
require_relative 'models/user'
require_relative 'models/account' 
require_relative 'models/transaction' 
require_relative 'models/transfer'


class App < Sinatra::Application
  enable :sessions # Habilita el uso de sesiones (ultimos cambios)
  set :session_secret, 'c1oV3rW4ll3t_s3ss10n_s3cr3t_2025_!@#_largo_para_seguridad_1234567890abcdef' # Cambia esto por algo seguro en producción

  set :public_folder, File.expand_path('../public', __FILE__)
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
    erb :login
  end

  # Rutas para vistas
  get '/signup' do
    #Si el usuario ya inicio sesion, no podrá volver a la página de signup
    redirect '/welcome' if session[:dni]
    erb :signup
  end

  get '/login' do
    #Si el usuario ya inicio sesion, no podrá volver a la página de login
    redirect '/welcome' if session[:dni]
    erb :login
  end

  post '/signup' do
    user = User.new(
      dni: params[:dni],
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email],
      password: params[:password]
    )
    if user.save
      # Crea la cuenta asociada automáticamente

      #primero genero un cvu que no exista
      begin
        new_cvu = rand(10**22).to_s.rjust(22,'0')
          #to_s -> pasa el numero random a string
          #rjust -> completa con ceros a la izquierda si faltan digitos
      end while Account.exists?(cvu:new_cvu)

      Account.create!(cvu: new_cvu, dni: user.dni, balance: 0)
      session[:dni] = user.dni
      redirect '/welcome'
    else
      @error = user.errors.full_messages.join(', ')
      erb :signup
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:dni] = user.dni
      redirect '/welcome'
    else
      @error = 'Wrong email or password'
      erb :login
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  # Modifica /welcome para usar el usuario autenticado
  get '/welcome' do
    redirect '/login' unless session[:dni]
    @user = User.find_by(dni: session[:dni])
    @account = Account.find_by(dni: @user.dni)
    erb :welcome
  end

  get '/dashboard' do
    redirect '/login' unless session[:dni]
    @user = User.find_by(dni: session[:dni])
    @account = Account.find_by(dni: @user.dni)
    @transactions = Transaction.where(account_cvu: @account.cvu).order(created_at: :desc)
    erb :dashboard
  end

  get '/deposit' do
    redirect '/login' unless session[:dni]
    erb :deposit
  end

  post '/deposit' do
    redirect '/login' unless session[:dni]
    @user = User.find_by(dni: session[:dni])
    @account = Account.find_by(dni: @user.dni)
    amount = params[:amount].to_i

    if amount > 0
      Transaction.create!(
        account_cvu: @account.cvu,
        amount: amount,
        date: Date.today,
        transaction_type: 'deposit',
        description: 'Deposit'
      )
      redirect '/dashboard'
    else
      @error = "Ammount must be greater than 0"
      erb :deposit
    end
  end

  get '/withdraw' do
    redirect '/login' unless session[:dni]
    erb :withdraw
  end

  post '/withdraw' do
    redirect '/login' unless session[:dni]
    @user = User.find_by(dni: session[:dni])
    @account = Account.find_by(dni: @user.dni)
    amount = params[:amount].to_i

    if amount > 0 && amount <= @account.balance
      Transaction.create!(
        account_cvu: @account.cvu,
        amount: amount,
        date: Date.today,
        transaction_type: 'withdrawal',
        description: 'Withdrawal'
      )
      redirect '/dashboard'
    else
      @error = "Invalid ammount or insufficient balance"
      erb :withdraw
    end
  end

  get '/transfer' do
    redirect '/login' unless session[:dni]
    erb :transfer
  end

  post '/transfer' do
    redirect '/login' unless session[:dni]
    @user = User.find_by(dni: session[:dni])
    @account = Account.find_by(dni: @user.dni)
    destination_cvu = params[:destination_cvu]
    amount = params[:amount].to_i

    dest_account = Account.find_by(cvu: destination_cvu)

    if dest_account.nil?
      @error = "Account with CVU #{destination_cvu} does not exist"
      return erb :transfer
    end

    if destination_cvu == @account.cvu
      @error = "You cannot transfer to your own account"
      return erb :transfer
    end

    if amount <= 0
      @error = "Ammount must be greater than 0"
      return erb :transfer
    end

    if amount > @account.balance
      @error = "Insufficient balance"
      return erb :transfer
    end

    ActiveRecord::Base.transaction do
      # Transacción de salida (origen)
      tx_out = Transaction.create!(
        account_cvu: @account.cvu,
        amount: amount,
        date: Date.today,
        transaction_type: 'transfer',
        description: "Transfer to #{destination_cvu}"
      )
      # Transacción de entrada (destino)
      tx_in = Transaction.create!(
        account_cvu: dest_account.cvu,
        amount: amount,
        date: Date.today,
        transaction_type: 'transfer',
        description: "Transfer recived from #{@account.cvu}"
      )
      # Registro en Transfer
      Transfer.create!(
        transaction_id: tx_out.transaction_id,
        from_cvu: @account.cvu,
        to_cvu: destination_cvu
      )
    end

    redirect '/dashboard'
  end
end