class Transfer < ActiveRecord::Base
  self.primary_key = 'transaction_id'
  belongs_to :transaction, foreign_key: 'transaction_id', primary_key: 'transaction_id'
  belongs_to :from_account, class_name: 'Account', foreign_key: 'from_cvu', primary_key: 'cvu'
  belongs_to :to_account, class_name: 'Account', foreign_key: 'to_cvu', primary_key: 'cvu'
end