require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  it 'displays usernames, profile pictures, and post count for each user' do
    first_user = User.create(name: 'Jose', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', post_counter: 0,
                             bio: 'Teacher from Mexico.')
    Post.create(author: first_user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)

    visit '/users'
    expect(page).to have_content(first_user.name)
    expect(page).to have_css("img[src*='#{first_user.photo}']")
    expect(page).to have_content('Number of posts: 1')
    click_on first_user.name
    expect(current_path).to eq(user_path(first_user))
  end
end
