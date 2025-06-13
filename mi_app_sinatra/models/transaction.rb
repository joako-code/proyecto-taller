class Transaction < ActiveRecord::Base
  self.primary_key = 'transaction_id'
  belongs_to :account, foreign_key: 'account_cvu', primary_key: 'cvu' #pertenece a una cuenta
  has_one :transfer, foreign_key: 'transaction_id', primary_key: 'transaction_id' #tiene una transferencia

  validates :amount, presence: true #valida que el monto este presente
  validates :date, presence: true #vaida que la fecha este presente
  validates :transaction_type, presence: true, inclusion: { in: %w[deposit withdrawal transfer] } #valida que el tipo de transaccion este presente y sea uno de los valores permitidos
  validates :account_cvu, presence: true #valida que el cvu de la cuenta este presente

  validate :sufficient_balance, on: :create #valida que el balance sea suficiente para una transaccion de retiro o transferencia

  after_create :apply_transaction #callback que se ejecuta despues de crear una transaccion

  private

  def sufficient_balance
    # Solo validar para retiros y transferencias de salida (no para transferencias recibidas)
    if transaction_type == 'withdrawal'
      errors.add(:base, "Saldo insuficiente para realizar la transacción") if account.balance < amount
    elsif transaction_type == 'transfer'
      # Solo validar si es una transferencia de salida (la descripción contiene "a" o el account_cvu es el origen)
      if description&.start_with?("Transferencia a") && account.balance < amount
        errors.add(:base, "Saldo insuficiente para realizar la transacción")
      end
    end
  end

  def apply_transaction
    case transaction_type
    when 'deposit'
      account.increment!(:balance, amount)
    when 'withdrawal'
      account.decrement!(:balance, amount)
    when 'transfer'
      if description&.start_with?("Transferencia a")
        account.decrement!(:balance, amount) # Solo debita si es salida
      elsif description&.start_with?("Transferencia recibida de")
        account.increment!(:balance, amount) # Solo acredita si es entrada
      end
    end
  end
end