class Transaction < ActiveRecord::Base
  self.primary_key = 'transaction_id'
  belongs_to :account, foreign_key: 'account_cvu', primary_key: 'cvu'
  has_one :transfer, foreign_key: 'transaction_id', primary_key: 'transaction_id'

  validates :amount, presence: true
  validates :date, presence: true
  validates :transaction_type, presence: true, inclusion: { in: %w[deposit withdrawal transfer] }
  validates :account_cvu, presence: true
end