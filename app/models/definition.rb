class Definition < ApplicationRecord
  belongs_to :slang
  belongs_to :user
  has_many :likes
end
