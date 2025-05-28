class User < ActiveRecord::Base
  has_many :accounts #tiene muchas cuentas
  validates :first_name, presence: true #valida que el nombre este presente
  validates :dni, presence: true, uniqueness: true #valida que el dni este presente y sea unico
end
