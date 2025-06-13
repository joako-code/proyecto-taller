class Transfer < ActiveRecord::Base
  self.primary_key = 'transaction_id' 
  belongs_to :associated_transaction, class_name: 'Transaction', foreign_key: 'transaction_id', primary_key: 'transaction_id' #pertenece a una transaccion
  belongs_to :from_account, class_name: 'Account', foreign_key: 'from_cvu', primary_key: 'cvu' #pertenece a una cuenta de origen
  belongs_to :to_account, class_name: 'Account', foreign_key: 'to_cvu', primary_key: 'cvu' #pertenece a una cuenta de destino

  validates :from_cvu, presence: true #valida que el cvu de origen este presente
  validates :to_cvu, presence: true #valida que el cvu de destino este presente
  validate :different_accounts #valida que las cuentas de origen y destino sean diferentes
  validate :to_account_exists #valida que la cuenta de destino exista

  private

  def different_accounts
    if from_cvu == to_cvu
      errors.add(:to_cvu, "no puede ser igual a la cuenta de origen") #error si las cuentas son iguales
    end
  end

  def to_account_exists
    unless Account.exists?(cvu: to_cvu)
      errors.add(:to_cvu, "debe corresponder a una cuenta existente") #error si la cuenta de destino no existe
    end
  end
end