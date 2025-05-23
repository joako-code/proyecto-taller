class Transaction < ActiveRecord::Base
    belongs_to :account #pertenece a una cuenta
end
