class Slang < ApplicationRecord
  belongs_to :user
  has_many :definitions
  has_many :users, through: :definitions
  # validates :user, presence: true, uniqueness: true
end
