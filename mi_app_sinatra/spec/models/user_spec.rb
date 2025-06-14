require_relative '../spec_helper'
require_relative '../../models/transaction'
require_relative '../../models/account'
require_relative '../../models/user'

RSpec.describe User do
  # Grupo de pruebas para validar la creacion del usuario
  before do
    User.create!(
      dni: '11111111',
      first_name: 'Existente',
      last_name: 'Usuario',
      phone: '123456789',
      email: 'existente@gmail.com',
      password: 'password123'
    )
  end

  context 'validations' do
    it 'es valido cuando se proporcionan todos los atributos requeridos' do
      user = User.new(
        dni: '12345678',
        first_name: 'Juan',
        last_name: 'Perez',
        phone: '123456789',
        email: 'juan@gmail.com',
        password: 'secret'
      )
      expect(user).to be_valid
    end

    it 'el usuario no es valido por falta de DNI' do
      user = User.new(
        first_name: 'Juan',
        last_name: 'Perez',
        phone: '123456789',
        email: 'juan@gmail.com',
        password: 'secret'
      )
      expect(user).not_to be_valid
    end

    it 'el usuario no es valido por falta de email' do
      user = User.new(
        dni: '12345678',
        first_name: 'Juan',
        last_name: 'Perez',
        phone: '123456789',
        password: 'secret'
      )
      expect(user).not_to be_valid
    end

    it 'el usuario no es valido si el dni ya esta en uso' do
      user = User.new(
        dni: '11111111',
        first_name: 'Otro',
        last_name: 'Usuario',
        phone: '987654321',
        email: 'otro@gmail.com',
        password: 'clave123'
      )
      expect(user).not_to be_valid
    end

    it 'el usuario no es valido si el email ya esta en uso' do
      user = User.new(
        dni: '22222222',
        first_name: 'Nuevo',
        last_name: 'Usuario',
        phone: '111111111',
        email: 'existente@gmail.com',
        password: 'clave123'
      )
      expect(user).not_to be_valid
    end

    it 'el usuario no es valido si el email no tiene formato correcto' do
      user = User.new(
        dni: '33333333',
        first_name: 'Luis',
        last_name: 'Rodriguez',
        phone: '333333333',
        email: 'malformato',
        password: 'clave123'
      )
      expect(user).not_to be_valid
    end

    it 'el usuario no es valido si la contraseña es muy corta' do
      user = User.new(
        dni: '44444444',
        first_name: 'Corto',
        last_name: 'Pass',
        phone: '444444444',
        email: 'corto@gmail.com',
        password: '123'
      )
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include "must have at least 6 characters\n"
    end

    it 'el usuario no es valido si falta el nombre' do
      user = User.new(
        dni: '55555555',
        last_name: 'SinNombre',
        phone: '555555555',
        email: 'sn@gmail.com',
        password: 'clave123'
      )
      expect(user).not_to be_valid
    end

    it 'el usuario no es valido si falta el apellido' do
      user = User.new(
        dni: '66666666',
        first_name: 'SinApellido',
        phone: '666666666',
        email: 'sa@gmail.com',
        password: 'clave123'
      )
      expect(user).not_to be_valid
    end
  end
end

