class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  after_save :posts_counter

  def posts_counter
    user.update(post_counter: user.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
