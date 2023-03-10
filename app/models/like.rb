class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :likes_counter

  def likes_counter
    post.update(likes_counter: user.likes.count)
  end
end
