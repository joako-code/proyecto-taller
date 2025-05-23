class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id # id de usuario
      t.string :email # mail
      t.decimal :balance, default: 0.0 # saldo
      t.string :cvu # cvu
      t.string :alias # alias
      t.string :password # contraseña

      t.timestamps
    end

    add_index :accounts, :email, unique: true
    add_index :accounts, :cvu, unique: true
    add_index :accounts, :alias, unique: true
    add_index :accounts, :user_id
  end
end
