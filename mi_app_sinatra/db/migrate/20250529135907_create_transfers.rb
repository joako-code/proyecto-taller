class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers, id: false, primary_key: :transaction_id do |t|
      t.integer :transaction_id, primary_key: true
      t.string :from_cvu, null: false
      t.string :to_cvu, null: false

      t.timestamps
    end
    add_foreign_key :transfers, :transactions, column: :transaction_id, primary_key: :transaction_id
    add_foreign_key :transfers, :accounts, column: :from_cvu, primary_key: :cvu
    add_foreign_key :transfers, :accounts, column: :to_cvu, primary_key: :cvu
  end
end