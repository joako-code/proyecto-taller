class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: false, primary_key: :dni do |t|
      t.string :dni, primary_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end