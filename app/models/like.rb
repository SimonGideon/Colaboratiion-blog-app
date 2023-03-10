class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :likes_counter

  def likes_counter
    post.update(likes_counter: author.likes.count)
  end
end
