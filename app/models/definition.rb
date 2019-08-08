class Definition < ApplicationRecord
  belongs_to :slang
  belongs_to :user
  has_many :likes
  validates :user, presence: true
  # validates :slang, uniqueness: true
  validates :slang, uniqueness: { scope: :user }
end
