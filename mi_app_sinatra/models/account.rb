class Account < ActiveRecord::Base
  self.primary_key = 'cvu'
  belongs_to :user, foreign_key: 'dni', primary_key: 'dni' #pertenece a un usuario
  has_many :transactions, foreign_key: 'account_cvu', primary_key: 'cvu' #tiene muchas transacciones
  has_many :sent_transfers, class_name: 'Transfer', foreign_key: 'from_cvu', primary_key: 'cvu' #tiene muchas transferencias enviadas
  has_many :received_transfers, class_name: 'Transfer', foreign_key: 'to_cvu', primary_key: 'cvu' #tiene muchas transferencias recibidas

  validates :cvu, presence: true, uniqueness: true #valida que el cvu este presente y sea unico
  validates :dni, presence: true, uniqueness: true #valida que el dni este presente y sea unico
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 } #valida que el balance este presente y no sea negativo
end