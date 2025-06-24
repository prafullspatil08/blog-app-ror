class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  enum role: { viewer: 0, editor: 1, admin: 2 }
  has_many :posts
  include Pretender
end
