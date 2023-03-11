require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Jhon', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', post_counter: 0, bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'name should not be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  after { subject.save }

  it 'name should be present' do
    subject.name = 'Jhon'
    expect(subject).to be_valid
  end

  it 'name should not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe '#recent_post' do
    let!(:post1) do
      subject.posts.create(created_at: 3.days.ago, title: 'First post', comments_counter: 0, likes_counter: 0)
    end
    let!(:post2) do
      subject.posts.create(created_at: 2.days.ago, title: 'Second post', comments_counter: 0, likes_counter: 0)
    end
    let!(:post3) do
      subject.posts.create(created_at: 1.day.ago, title: 'Third post', comments_counter: 0, likes_counter: 0)
    end
    let!(:post4) do
      subject.posts.create(created_at: 4.days.ago, title: 'Fourth post', comments_counter: 0, likes_counter: 0)
    end

    it 'returns the 3 most recent posts' do
      expect(subject.recent_post).to eq([post3, post2, post1])
    end

    it 'does not return older posts' do
      expect(subject.recent_post).to_not include(post4)
    end
  end
end
