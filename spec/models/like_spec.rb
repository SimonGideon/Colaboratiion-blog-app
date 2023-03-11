require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, author: user) }

  subject { described_class.new(author: user, post:) }

  it 'increments the post likes counter when created' do
    expect { subject.save }.to change { post.likes_counter }.by(1)
  end

  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq :belongs_to
    end
  end
end
