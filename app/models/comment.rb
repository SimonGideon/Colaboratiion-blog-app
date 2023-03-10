class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :comments_counter

  def comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
