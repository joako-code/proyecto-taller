class RemoveAccountIdFromTransactions < ActiveRecord::Migration[8.0]
  def change
    remove_column :transactions, :account_id, :integer
  end
end
