# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
end
