class RemoveEmailAndPasswordFromAccounts < ActiveRecord::Migration[8.0]
  def change
    remove_column :accounts, :email, :string
    remove_column :accounts, :password, :string
  end
end