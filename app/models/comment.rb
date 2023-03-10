class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :posts

  def comments_counter
    posts.update(comments_counter: user.comments.count)
  end
end
