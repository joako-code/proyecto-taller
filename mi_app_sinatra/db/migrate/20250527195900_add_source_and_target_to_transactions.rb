class AddSourceAndTargetToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :source_account_id, :integer
    add_column :transactions, :target_account_id, :integer
    add_index :transactions, :source_account_id
    add_index :transactions, :target_account_id
  end
end
