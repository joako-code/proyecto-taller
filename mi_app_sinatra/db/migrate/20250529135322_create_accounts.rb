class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts, id: false, primary_key: :cvu do |t|
      t.string :cvu, primary_key: true
      t.string :dni, null: false
      t.string :email, null: false
      t.integer :balance, null: false
      t.string :password, null: false

      t.timestamps
    end
    add_index :accounts, :email, unique: true
    add_index :accounts, :dni, unique: true
    add_foreign_key :accounts, :users, column: :dni, primary_key: :dni
  end
end