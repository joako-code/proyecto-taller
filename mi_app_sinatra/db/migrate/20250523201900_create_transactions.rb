class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :num_transaction #numero de transaccion
      t.datetime :date #fecha y hora
      t.string :description #descripcion
      t.decimal :amount #monto
      t.integer :account_id # cuenta

      t.timestamps
    end

    add_index :transactions, :num_transaction, unique: true
    add_index :transactions, :account_id
  end
end
