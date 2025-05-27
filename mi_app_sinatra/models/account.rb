class Account < ActiveRecord::Base
  belongs_to :user #pertenece a un usuario
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: :source_account_id #tiene muchas transacciones enviadas
  has_many :received_transactions, class_name: 'Transaction', foreign_key: :target_account_id #tiene muchas transacciones recibidas
end
