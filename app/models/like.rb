class Like < ApplicationRecord
  belongs_to :user
  belongs_to :definition

  validates :user, uniqueness: { scope: :definition }
end
