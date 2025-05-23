class AddForeignkeys < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :accounts, :users, column: :user_id
    add_foreign_key :transactions, :accounts, column: :account_id
  end
end
