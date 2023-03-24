class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :text

  belongs_to :post
end
