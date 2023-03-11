require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Jane', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', post_counter: 0, bio: 'Developer from Spain.') }

  subject { Post.new(author: user, title: 'Test post', comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'should have an author' do
    expect(subject.author).to eq(user)
  end

  it 'should update author post_counter after save' do
    expect(user.post_counter).to eq(1)
  end

  it 'should have a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater or equal to zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater or equal to zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_comments' do
    let(:user) { User.create(name: 'Jane', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', post_counter: 0, bio: 'Developer from Spain.') }
    let!(:post) { Post.create(author: user, title: 'Test post', comments_counter: 0, likes_counter: 0) }
    let!(:comment1) { Comment.create(post:, author: user, text: 'First comment', created_at: 3.days.ago) }
    let!(:comment2) { Comment.create(post:, author: user, text: 'Second comment', created_at: 2.days.ago) }
    let!(:comment3) { Comment.create(post:, author: user, text: 'Third comment', created_at: 1.day.ago) }
    let!(:comment4) { Comment.create(post:, author: user, text: 'Fourth comment', created_at: 4.days.ago) }
    let!(:comment5) { Comment.create(post:, author: user, text: 'Fifth comment', created_at: 5.days.ago) }
    let!(:comment6) { Comment.create(post:, author: user, text: 'Sixth comment', created_at: 6.days.ago) }
    let!(:comment7) { Comment.create(post:, author: user, text: 'Seventh comment', created_at: 7.days.ago) }

    it 'returns the 5 most recent comments' do
      expect(post.recent_comments).to eq([comment3, comment2, comment1, comment4, comment5])
    end

    it 'does not return older comments' do
      expect(post.recent_comments).not_to include(comment6)
    end
  end

  describe 'associations' do
    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end
  end
end
