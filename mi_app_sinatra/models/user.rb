class User < ActiveRecord::Base
    has_many :accounts #tiene muchas cuentas
end
