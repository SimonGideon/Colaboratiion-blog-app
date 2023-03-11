FactoryBot.define do
  factory :user do
    name { 'Jane' }
    photo { 'https://unsplash.com/photos/F_-0BxGuVvo' }
    post_counter { 0 }
    bio { 'Developer from Spain.' }
  end

  factory :post do
    association :author, factory: :user
    title { 'Test post' }
    comments_counter { 0 }
    likes_counter { 0 }
  end
end
