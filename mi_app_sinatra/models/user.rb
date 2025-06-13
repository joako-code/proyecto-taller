class User < ActiveRecord::Base
  self.primary_key = 'dni' # Define el dni como la clave primaria (ya que no se usa id)
  has_one :account, foreign_key: 'dni', primary_key: 'dni' #tien una cuenta

  has_secure_password # Agrega autenticación segura con contraseña

  validates :first_name, presence: true #valida que el nombre este presente
  validates :last_name, presence: true #valida que el apellido este presente
  validates :phone, presence: true, format: { with: /\A\d{7,15}\z/, message: "El telefono debe ser valido\n" } #valida que el telefono este presente
  validates :dni, presence: true, uniqueness: true, format: {with: /\A\d{7,8}\z/,message: "debe tener exactamente 8 dígitos numéricos, sin puntos ni letras\n"} #valida que el dni este presente y sea unico
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP,message: "No es un email valido\n"} #valida que el email este presente y sea unico
end




