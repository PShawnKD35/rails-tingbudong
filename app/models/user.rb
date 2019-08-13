class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :definitions
  has_many :slangs
  has_many :likes
  acts_as_token_authenticatable

  def password_required?
    !self.wechat_id
  end
  
end
