require_relative '../spec_helper'
require_relative '../../models/transaction'
require_relative '../../models/account'
require_relative '../../models/user'

RSpec.describe Transaction do
  let(:user) { User.create!(dni: '12345678', first_name: 'Test', last_name: 'User', phone: '35816588564', email: 'test@example.com', password: '123456') }
  let(:account) { Account.create!(cvu: 'CVU123', dni: user.dni, balance: 100) }

  context 'validations' do
    it 'no permite crear transacción si no hay saldo suficiente' do
      transaction = Transaction.new(
        account_cvu: account.cvu,
        amount: 150,
        date: Date.today,
        transaction_type: 'withdrawal'
      )
      expect(transaction).not_to be_valid
      expect(transaction.errors[:base]).to include("Saldo insuficiente para realizar la transacción")
    end

    it 'permite crear transacción si hay saldo suficiente' do
      transaction = Transaction.new(
        account_cvu: account.cvu,
        amount: 50,
        date: Date.today,
        transaction_type: 'withdrawal'
      )
      expect(transaction).to be_valid
    end
  end

  context 'after create callback' do
    it 'debita el balance correctamente' do
      Transaction.create!(
        account_cvu: account.cvu,
        amount: 40,
        date: Date.today,
        transaction_type: 'withdrawal'
      )
      expect(account.reload.balance).to eq(60)
    end
  end
end