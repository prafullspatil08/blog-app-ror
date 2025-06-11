class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { viewer: 0, editor: 1, admin: 2 }
  has_many :posts
  audited
  include Pretender
end
