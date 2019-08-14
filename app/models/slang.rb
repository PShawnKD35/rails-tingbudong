class Slang < ApplicationRecord
  belongs_to :user
  has_many :definitions
  has_many :users, through: :definitions
  acts_as_taggable_on :tags, :dialects
  acts_as_favoritable

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validate :validate_tag

  before_save :update_pinyin, if: :name_changed?

  private

  def update_pinyin
    if name.match?(/[\u4e00-\u9fa5]/)
      self.pinyin = PinYin.sentence(name, :unicode)
    else
      self.pinyin = ""
    end
  end

  def validate_tag
    max_tags = 20
    errors[:tag_list] << "#{max_tags} tags maximum" if tag_list.count > max_tags
    max_tag_length = 15
    tag_list.each do |tag|
      errors.add(:tag_list, "Tag exceeded maximum length of #{max_tag_length}: #{tag}") unless tag.length <= max_tag_length
    end
  end
end
