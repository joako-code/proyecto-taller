require_relative '../spec_helper'
require_relative '../../models/transaction'
require_relative '../../models/account'
require_relative '../../models/user'


RSpec.describe Account do
  # Crea un usuario valido para asociar a la cuenta
  let(:user) do
    User.create!(
      dni: '87654321',
      first_name: 'Ana',
      last_name: 'García',
      phone: '987654321',
      email: 'ana@gmail.com',
      password: 'pass123'
    )
  end
  # Grupo de pruebas para validar la creacion de cuentas
  context 'validations' do
    it 'es valida cuando tiene un CVU, un DNI válido y un balance' do
      account = Account.new(
        cvu: 'CVU456',
        dni: user.dni,
        balance: 500
      )
      expect(account).to be_valid
    end
    it 'la cuenta no es valida por falta del CVU' do
      account = Account.new(
        dni: user.dni,
        balance: 500
      )
      expect(account).not_to be_valid
    end
    it 'la cuenta no es valida por falta de balance' do
      account = Account.new(
        cvu: 'CVU456',
        dni: user.dni
      )
      expect(account).not_to be_valid
    end
  end
end
