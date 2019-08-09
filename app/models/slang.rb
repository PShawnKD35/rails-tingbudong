class Slang < ApplicationRecord
  belongs_to :user
  has_many :definitions
  has_many :users, through: :definitions

  acts_as_taggable_on :tags, :dialects

  validates :name, presence: true, uniqueness: true, allow_blank: false
end
