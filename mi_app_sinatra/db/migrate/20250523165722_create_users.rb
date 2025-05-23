class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :dni #dni
      t.string :first_name #nombre
      t.string :last_name #apellido
      t.string :phone #telefono

      t.timestamps
    end

    add_index :users, :dni, unique: true
  end
end
