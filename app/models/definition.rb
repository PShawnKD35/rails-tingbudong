class Definition < ApplicationRecord
  belongs_to :slang
  belongs_to :user
  has_many :likes

  validates :slang, uniqueness: { scope: :user }
  validates :content, presence: true, allow_blank: false, length: {minimum: 1}
end
