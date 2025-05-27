class Transaction < ActiveRecord::Base
  belongs_to :source_account, class_name: 'Account', optional: true #pertenece a una cuenta origen
  belongs_to :target_account, class_name: 'Account', optional: true #pertenece a una cuenta destino

  validates :amount, numericality: { greater_than: 0 } #valida monto > 0
  validates :source_account, presence: true #valido que la cuenta origen este presente
  validates :target_account, presence: true #valido que la cuenta destino este presente
  validate :source_account_has_sufficient_balance, if: -> { source_account.present? && amount.present? } #valida que la cuenta origen tenga saldo suficiente


  after_create :transfer_balance  # Callback: despues de crear la transaccion transfiere el saldo

  private

  def source_account_has_sufficient_balance
    if source_account.balance < amount
      errors.add(:amount, "Saldo insuficiente en la cuenta origen") #Error si el saldo de la cuenta origen es insuficiente
    end
  end

  def transfer_balance # Realiza la transferencia de saldo entre cuentas
    ActiveRecord::Base.transaction do
      source_account.update!(balance: source_account.balance - amount)
      target_account.update!(balance: target_account.balance + amount)
    end
  end
end
