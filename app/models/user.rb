class User < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts

  def recent_post
    posts.order(created_at: :desc).limit(3)
  end
end
