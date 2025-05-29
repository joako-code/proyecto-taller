class Transaction < ActiveRecord::Base
  self.primary_key = 'transaction_id'
  belongs_to :account, foreign_key: 'account_cvu', primary_key: 'cvu' #pertenece a una cuenta
  has_one :transfer, foreign_key: 'transaction_id', primary_key: 'transaction_id' #tiene una transferencia

  validates :amount, presence: true #valida que el monto este presente
  validates :date, presence: true #vaida que la fecha este presente
  validates :transaction_type, presence: true, inclusion: { in: %w[deposit withdrawal transfer] } #valida que el tipo de transaccion este presente y sea uno de los valores permitidos
  validates :account_cvu, presence: true #valida que el cvu de la cuenta este presente
end