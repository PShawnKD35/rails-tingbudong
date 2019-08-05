class Slang < ApplicationRecord
  has_many :definitions
  has_many :users, through: :definitions
end
