class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions, primary_key: :transaction_id do |t|
      t.integer :amount, null: false
      t.date :date, null: false
      t.string :description, limit: 146
      t.string :transaction_type, null: false
      t.string :account_cvu, null: false

      t.timestamps
    end
    add_foreign_key :transactions, :accounts, column: :account_cvu, primary_key: :cvu
  end
end