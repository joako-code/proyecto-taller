class Account < ActiveRecord::Base
    belongs_to :user #pertenece a un usuario
    has_many :transactions #tiene muchas transacciones
end
