class Slang < ApplicationRecord
  belongs_to :user
  has_many :definitions
  has_many :users, through: :definitions
  acts_as_taggable_on :tags, :dialects
  acts_as_favoritable

  validates :name, presence: true, uniqueness: true, allow_blank: false

  before_save :update_pinyin, if: :name_changed?

  private

  def update_pinyin
    self.pinyin = PinYin.of_string(name, :unicode).join(' ')
  end
end
