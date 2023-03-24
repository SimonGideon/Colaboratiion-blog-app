class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :comments_counter, :likes_counter

  has_many :comments
end
