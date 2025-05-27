class User < ActiveRecord::Base
  has_many :accounts
  validates :first_name, presence: true
  validates :dni, presence: true, uniqueness: true
end
